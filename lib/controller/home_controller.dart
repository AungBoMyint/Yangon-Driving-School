import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hammies_user/model/form/car_licence_form.dart';
import 'package:hammies_user/model/form/course_form.dart';
import 'package:hammies_user/model/form/driving_licence_form.dart';
import 'package:hammies_user/model/hive_purchase_item.dart';
import 'package:hammies_user/model/hive_reward_product.dart';
import 'package:hammies_user/model/question/sub_question.dart';
import 'package:hammies_user/model/reward_product.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:hammies_user/widgets/show_dialog/show_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../model/purchase_item.dart';

import '../data/constant.dart';
import '../data/enum.dart';
import '../model/hive_item.dart';
import '../model/hive_purchase.dart';
import '../model/item.dart';
import '../model/purchase.dart';
import '../model/question/question.dart';
import '../model/user.dart';
import '../service/api.dart';
import '../service/auth.dart';
import '../service/database.dart';
import '../widgets/show_loading/show_loading.dart';

class HomeController extends GetxController {
  final Auth _auth = Auth();
  final Database _database = Database();
  final Api _api = Api();
  var currentUserDeviceToken = "".obs;
  final ImagePicker _imagePicker = ImagePicker();
  var parentGuideLineID = "".obs;
  Rxn<Question> mainQuestion = Rxn<Question>();
  Rxn<SubQuestion> editSubQuestion = Rxn<SubQuestion>();
  RxList<PurchaseModel> purchaseModelList = <PurchaseModel>[].obs;
  RxList<CourseForm> enrollList = <CourseForm>[].obs;
  RxList<DrivingLicenceForm> drivingLicenceFormList = <DrivingLicenceForm>[].obs;
  RxList<CarLicenceForm> carLicenceFormList = <CarLicenceForm>[].obs;
  var alreadyWatchIfAdmin = false.obs;

  void setMainQuestion(Question id){
    mainQuestion.value = id;
  }

  void setParentGuideLineID(String id){
    parentGuideLineID.value = id;
  }

  void setEditSubQuestion(SubQuestion ? subQuestion){
    editSubQuestion.value = subQuestion;
  }

  var widgetInput = <String, dynamic>{};

  final RxBool authorized = false.obs;
  final Rxn<AuthUser?> currentUser = Rxn<AuthUser?>(null);

  final RxBool phoneState = false.obs;
  final codeSentOnWeb = false.obs; //codeSentOnWeb on Web
  final TextEditingController _phoneCodeController =
      TextEditingController(); //On Web
  late SharedPreferences
      sharedPref; //Share Preference to Store User's Order Data
  String? townshipName; //Township Name
  var paymentOptions = PaymentOptions.None.obs; //Payment Option Initial Value
  var checkOutStep = 0.obs; //Check Out Step
  var bankSlipImage = "".obs;
  Map<String, dynamic> townShipNameAndFee = {}; //Township Name and Fee

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  final RxString _codeSentId = ''.obs;
  final RxInt _codeSentToken = 0.obs;

  final RxList<PurchaseItem> myCart = <PurchaseItem>[].obs;
  final RxMap<String, RewardProduct> myRewardCart =
      <String, RewardProduct>{}.obs;

  final RxList<RewardProduct> rewardProductList = <RewardProduct>[].obs;

  int currentUserPoint = 0;

  bool isCanAdd(RewardProduct reward) {
    return currentUserPoint > (reward.requirePoint * 1);
  }
  
   var firstTimePressedCart = false.obs;
  bool checkToAcceptOrder(){
  if(myRewardCart.isEmpty){
    Get.snackbar('Error', "Cart is empty");
    return false;
  }else if(townShipNameAndFee.isEmpty){
    Get.snackbar('Error', "Need to choose a township");
    firstTimePressedCart.value = true;
    return false;
  }else{
    return true;
  }
 }

  void addToRewardCart(RewardProduct product, int index) {
    debugPrint("****RewardP : ${product.requirePoint}");
    debugPrint("****RewardC : ${product.count}");
    if (currentUserPoint < (product.requirePoint * 1)) {
      showNotEnoughPoint();
      return;
    }
    rewardProductList[index] = product.copyWith(count: 1);
    myRewardCart[product.id] = product.copyWith(
      count: 1,
    );
    currentUserPoint = currentUserPoint - (product.requirePoint * 1);
  }

  void reduceRewardCount(RewardProduct product) {
    if (product.count! == 1) {
      myRewardCart.remove(product.id);
      rewardProductList.value = rewardProductList.map((element) {
        if (element.id == product.id) {
          return element.copyWith(count: 0);
        }
        return element;
      }).toList();
    } else {
      var previousCount = product.count!;
      myRewardCart[product.id] = product.copyWith(
        count: previousCount - 1,
      );
    }
    currentUserPoint = currentUserPoint + (product.requirePoint * 1);
    debugPrint("*******CurrentUserPoint: $currentUserPoint");
  }

  void addRewardCount(RewardProduct product) {
    var previousCount = product.count!;
    if (currentUserPoint < (product.requirePoint * 1)) {
      showNotEnoughPoint();
    } else {
      currentUserPoint = currentUserPoint - (product.requirePoint * 1);
      myRewardCart[product.id] = product.copyWith(count: previousCount + 1);
    }
    debugPrint("*******CurrentUserPoint: $currentUserPoint");
  }

  bool isOwnBrand = false;
  int mouseIndex = -1; //Mouse Region
  var purchaseId = "".obs;
  Box<HivePurchase> purchaseHiveBox =
      Hive.box(purchaseBox); //Current User's Order History Database

  void setPurchaseId(String id) {
    if (purchaseId.value == id) {
      purchaseId.value = "";
    } else {
      purchaseId.value = id;
    }
  }

  void changeMouseIndex(int i) {
    // Change Mouse Region
    mouseIndex = i;
    debugPrint("On Mouse Exist************");
    update();
  }

  //Make
  void makeAdded(ItemModel model) {
    items.value = items.map((element) {
      if (element.id == model.id) {
        return element.copyWith(count: 1);
      }
      return element;
    }).toList();
  }

  void remakeAdd(ItemModel model) {
    items.value = items.map((element) {
      if (element.id == model.id) {
        return element.copyWith(count: 0);
      }
      return element;
    }).toList();
  }

  //Set Shipping Fee
  void setTownshipName(String? val) {
    townshipName = val!;
    update();
  }

  //Set Township Name
  void setTownShipNameAndShip({required String name, required String fee}) {
    townShipNameAndFee = {
      "townName": name,
      "fee": int.parse(fee),
    };
    update();
  }

  //Change Payment Option
  void changePaymentOptions(PaymentOptions option) {
    paymentOptions.value = option;
  }

  //Change Step Index
  void changeStepIndex(int value) {
    checkOutStep.value = value;
  }

  //Set Bank Slip Image
  void setBankSlipImage(String image) {
    bankSlipImage.value = image;
  }

  void addToCart({required ItemModel itemModel, String? color, String? size}) {
    try {
      final PurchaseItem _item = myCart.firstWhere((item) =>
          item.id == itemModel.id && item.color == color && item.size == size);
      myCart.value = myCart.map((element) {
        if (_item.id == element.id) {
          return PurchaseItem(
            id: element.id,
            itemName: element.itemName,
            count: element.count + 1,
            size: element.size,
            color: element.color,
            priceType: element.priceType,
            price: element.price,
          );
        }
        return element;
      }).toList();
    } catch (e) {
      myCart.add(PurchaseItem(
        id: itemModel.id,
        itemName: itemModel.name,
        count: 1,
        size: size ?? itemModel.size.split(",").first,
        color: color ?? itemModel.color.split(",").first,
        priceType: "",
        price: itemModel.price,
      ));
    }
  }

  final RxList<ItemModel> items = <ItemModel>[].obs;
  final RxList<ItemModel> brandItems = <ItemModel>[].obs; //Brand Item
  final RxList<ItemModel> exportAndBrandItems = <ItemModel>[].obs;
  final RxList<ItemModel> searchitems = <ItemModel>[].obs;

  //set export and brand items when edit page start
  /*void setExportAndBrandItems() {
    exportAndBrandItems.value = [];
    items.forEach((element) {
      exportAndBrandItems.add(element);
    });
    brandItems.forEach((element) {
      exportAndBrandItems.add(element);
    });
  }*/

  final Rx<ItemModel> selectedItem = ItemModel(
    id: "",
    photo: '',
    photo2: '',
    photo3: '',
    deliverytime: '',
    name: '',
    price: 0,
    color: '',
    desc: '',
    size: '',
    star: 0,
    category: '',
    originalPrice: 0,
    originalQuantity: 0,
    remainQuantity: 0,
  ).obs;

  void setSelectedItem(ItemModel item) {
    selectedItem.value = item;
  }

  final Rx<ItemModel> editItem = ItemModel(
    photo: '',
    photo2: '',
    photo3: '',
    deliverytime: '',
    name: '',
    price: 0,
    color: '',
    desc: '',
    size: '',
    star: 0,
    category: '',
    originalPrice: 0,
    originalQuantity: 0,
    remainQuantity: 0,
    id: '',
  ).obs;

  void setEditItem(ItemModel itemModel) {
    editItem.value = itemModel;
  }

  ItemModel getItem(String id) {
    try {
      return items.firstWhere((e) => e.id == id);
    } catch (e) {
      return ItemModel(
        photo: '',
        photo2: '',
        photo3: '',
        deliverytime: '',
        name: '',
        price: 0,
        color: '',
        desc: '',
        size: '',
        star: 0,
        category: '',
        originalPrice: 0,
        originalQuantity: 0,
        remainQuantity: 0,
        id: '',
      );
    }
  }

  //Get Brand Item
  ItemModel getBrandItem(String id) {
    try {
      return brandItems.firstWhere((e) => e.id == id);
    } catch (e) {
      return ItemModel(
        photo: '',
        photo2: '',
        photo3: '',
        deliverytime: '',
        name: '',
        price: 0,
        color: '',
        desc: '',
        size: '',
        star: 0,
        category: '',
        id: '',
        originalPrice: 0,
        originalQuantity: 0,
        remainQuantity: 0,
      );
    }
  }

  List<ItemModel> getItems() => category.value == 'All'
      ? items
      : items.where((e) => e.category == category.value).toList();

  //GetBrandItems
  List<ItemModel> getBrandItems() => brandCategory.value == 'All'
      ? brandItems
      : brandItems.where((e) => e.category == brandCategory.value).toList();

  List<String> categoryList() {
    final List<String> _data = [
      'All',
    ];

    for (var i = 0; i < items.length; i++) {
      if (!_data.contains(items[i].category)) {
        _data.add(items[i].category);
      }
    }

    if (items.isEmpty) {
      _data.clear();
    }
    return _data;
  }

  //Brand Category List
  List<String> brandCategoryList() {
    final List<String> _data = [
      'All',
    ];

    for (var i = 0; i < brandItems.length; i++) {
      if (!_data.contains(brandItems[i].category)) {
        _data.add(brandItems[i].category);
      }
    }

    if (brandItems.isEmpty) {
      _data.clear();
    }
    return _data;
  }

  List<ItemModel> pickUp() {
     List<ItemModel> result = [];
    try{
      result = items.where((e) => e.category == "New Products").toList();
    }catch(e){
      debugPrint("NO product found");
    }
    return result;
  }


  List<ItemModel> hot() =>
      items.where((e) => e.category == 'Hot Sales').toList();

  void removeItem(String id) => items.removeWhere((item) => item.id == id);

  //int shipping() => myCart.isEmpty ? 0 : shippingFee;

  void addCount(PurchaseItem p) {
    myCart.value = myCart.map((element) {
      if (element.id == p.id &&
          element.color == p.color &&
          element.size == p.size) {
        return PurchaseItem(
          id: element.id,
          itemName: element.itemName,
          count: element.count + 1,
          size: element.size,
          color: element.color,
          priceType: element.priceType,
          price: element.price,
        );
      }
      return element;
    }).toList();
    update([myCart]);
    updateSubTotal(true);
  }

  void remove(PurchaseItem p) {
    bool needToRemove = false;
    myCart.value = myCart.map((element) {
      if (element.id == p.id &&
          element.color == p.color &&
          element.size == p.size) {
        if (element.count > 1) {
          return PurchaseItem(
            id: element.id,
            itemName: element.itemName,
            count: element.count - 1,
            size: element.size,
            color: element.color,
            priceType: element.priceType,
            price: element.price,
          );
        }
        needToRemove = true;
        return element;
      }
      return element;
    }).toList();
    if (needToRemove) {
      remakeAdd(items.firstWhere((element) => element.id == p.id));
      myCart.removeWhere((element) =>
          element.id == p.id &&
          element.color == p.color &&
          element.size == p.size);
    }
    updateSubTotal(true);
  }

  int subTotal = 0;
  void updateSubTotal(bool isUpdate) {
    if (subTotal != 0) {
      subTotal = 0;
    }
    int price = 0;
    for (var i = 0; i < myCart.length; i++) {
      //print(items.firstWhere((element) => element.id == myCart[i].id).price);
      debugPrint("**********each price:$i: ${myCart[i].price}");
      /* price += items.firstWhere((element) => element.id == myCart[i].id).price *
          myCart[i].count;*/
      price += myCart[i].price * myCart[i].count;
    }
    subTotal = price;
    debugPrint("*************$subTotal");
    if (isUpdate) {
      update();
    }
  }

  //Get HiveItem
  HiveItem changeHiveItem(ItemModel model) {
    return HiveItem(
      id: model.id,
      photo: model.photo,
      photo2: model.photo2,
      photo3: model.photo3,
      name: model.name,
      deliverytime: model.deliverytime,
      price: model.price,
      desc: model.desc,
      color: model.color,
      size: model.size,
      star: model.star,
      category: model.category,
      originalPrice: model.originalPrice,
      originalQuantity: model.originalQuantity,
      remainQuantity: model.remainQuantity,
    );
  }
 
  //Get ItemModel
  ItemModel changeItemModel(HiveItem model) {
    return ItemModel(
      id: model.id,
      photo: model.photo,
      photo2: model.photo2,
      photo3: model.photo3,
      name: model.name,
      deliverytime: model.deliverytime,
      price: model.price,
      desc: model.desc,
      color: model.color,
      size: model.size,
      star: model.star,
      category: model.category,
      originalPrice: model.originalPrice,
      originalQuantity: model.originalQuantity,
      remainQuantity: model.remainQuantity,
    );
  }

  final RxList<PurchaseModel> _purchcases = <PurchaseModel>[].obs; ////

  List<PurchaseModel> purchcasesCashOn() {
    return _purchcases.where((item) => item.bankSlipImage == null).toList();
  }

  List<PurchaseModel> purchcasesPrePay() {
    return _purchcases.where((item) => item.bankSlipImage != null).toList();
  } //////////////////

  final RxBool isLoading = false.obs;
  Future<void> proceedToPay() async {
    showLoading();
    try {
      final total = subTotal + townShipNameAndFee["fee"] as int;
      final _purchase = PurchaseModel(
        id: Uuid().v1(),
        userId: currentUser.value!.id,
        dateTime: DateTime.now().toString(),
        items: myCart.isNotEmpty
            ? myCart.map((element) => element).toList()
            : null,
        rewardProductList: myRewardCart.isNotEmpty
            ? myRewardCart.values.map((e) => e).toList()
            : null,
        name: currentUser.value?.userName ?? "",
        email: currentUser.value?.emailAddress ?? "",
        phone: "",
        address: "",
        bankSlipImage: null,
        deliveryTownshipInfo: [
          townShipNameAndFee["townName"],
          townShipNameAndFee["fee"]
        ],
      );
      final hivePurchase = HivePurchase(
        id: Uuid().v1(),
        items: !(_purchase.items == null)
            ? _purchase.items
                ?.map((e) => HivePurchaseItem(
                      itemName: e.itemName,
                      count: e.count,
                      size: e.size,
                      color: e.color,
                      priceType: e.priceType,
                      price: e.price,
                    ))
                .toList()
            : null,
        rewardProductList: !(_purchase.rewardProductList == null)
            ? _purchase.rewardProductList?.map((e) {
                return HiveRewardProduct(
                  id: e.id,
                  name: e.name,
                  image: e.image,
                  count: e.count!,
                  requirePoints: e.requirePoint,
                );
              }).toList()
            : null,
        totalPrice: total,
        deliveryTownshipInfo: _purchase.deliveryTownshipInfo,
        dateTime: DateTime.now(),
      );

      await _database.writePurchaseData(_purchase).then((value) {
        refreshRewardCart();
        hideLoading();
        Get.back();
        Get.snackbar("လူကြီးမင်း Order တင်ခြင်း", 'အောင်မြင်ပါသည်');
        purchaseHiveBox.put(hivePurchase.id, hivePurchase);
      }); //submit success

      myCart.clear();
      navIndex.value = 0;
      update([myCart, navIndex]);
      refreshRewardCart();
    } catch (e) {
      hideLoading();
      Get.snackbar("လူကြီးမင်း Order တင်ခြင်း", 'မအောင်မြင်ပါ');
      print("proceed to pay error $e");
    }
  }

  void refreshRewardCart() {
    currentUserPoint = currentUser.value!.points;
    rewardProductList.value = rewardProductList.map((element) {
      if (element.count! > 0) {
        return element.copyWith(count: 0);
      }
      return element;
    }).toList();
    myRewardCart.value = {};
  }

  Future<void> login() async {
    try {
      if (_codeSentId.value.isNotEmpty || phoneState.value) {
        await confirm();
        return;
      }
      //Change method base on Platform Conditionally
      if (kIsWeb) {
        debugPrint("Web Sign In"); //Debug Print
        //web login
        await _auth.loginInWeb(
          phoneNumber: phoneController.text,
          enterCode: (callBack) => showDialogToEnterPhoneCode(
            (phoneCode) => callBack(phoneCode),
          ),
        ); //FOR WEB SIGNIN WITH PHONE
      } else {
        await _auth.login(
          phoneNumber: phoneController.text,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            _codeSentId.value = verificationId;
            _codeSentToken.value = forceResendingToken ?? 0;
            update([_codeSentId, _codeSentToken]);
          },
          verificationFailed: (FirebaseAuthException error) {},
        );
        phoneState.value = true;
      }
    } catch (e) {
      print("login error $e");
    }
  }

  Future<void> confirm() async {
    try {
      await _auth.loginWithCerdential(PhoneAuthProvider.credential(
        verificationId: _codeSentId.value,
        smsCode: verificationController.text,
      ));
      _codeSentId.value = '';
      phoneState.value = false;
      phoneController.clear();
      verificationController.clear();
    } catch (e) {
      print("confirm error is $e");
    }
  }

  Future<void> logout() async {
    Get.offAllNamed(introScreen);
    try {
      await _auth.logout();
    } catch (e) {
      print("logout error is $e");
    }
  }

  //Get User's Order Data
  List<String> getUserOrderData() {
    return sharedPref.getStringList("userOrder") ?? [];
  }

  //Set User's Order Data or Not
  Future<void> setUserOrderData({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    //Making Purchase Model
    try {} catch (e) {}
    final list = getUserOrderData();
    //Check data already contain with the same data inside SharedPreference
    if (list.isEmpty) {
      await sharedPref
          .setStringList("userOrder", [name, email, phone, address]);
    } else if ( //Something is changed by User,then we restore
        (name != list[0]) ||
            (email != list[1]) ||
            (phone != list[2]) ||
            (address != list[3])) {
      await sharedPref
          .setStringList("userOrder", [name, email, phone, address]);
    }
  }
  //-------------------------GET TOKEN--------------------//
    Future<void> getDeviceToken() async{
      try{
        currentUserDeviceToken.value = await FirebaseMessaging.instance.getToken() ?? "";
      }catch(e){
        debugPrint("**************Error Getting Token: $e");
      }
    }
    Future<void> saveTokenToDatabase(String token) async {
 
  if(currentUser.value!.status! >= 0){
    String userId = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore.instance.runTransaction((transaction) async{
    final secureSnapshot = await FirebaseFirestore.instance
    .collection(normalUserCollection)
    .doc(userId).get();
    transaction.update(secureSnapshot.reference, {
        "token": currentUserDeviceToken.value,
        });
  });
  }
}

 void watchOnlyIfAdmin(){
  alreadyWatchIfAdmin.value = true;
  _database.watchWithDateTime(courseFormCollection).listen((event) {//CourseForm
      enrollList.value = event.docs.map((e) => CourseForm.fromJson(e.data())).toList();
    });
    _database.watchWithDateTime(drivingLicenceCollection).listen((event) {//DrivingLicenceForm
      drivingLicenceFormList.value = event.docs.map((e) => DrivingLicenceForm.fromJson(e.data())).toList();
    });
    _database.watchWithDateTime(carLicenceCollection).listen((event) {//CarLicenceForm
      carLicenceFormList.value = event.docs.map((e) => CarLicenceForm.fromJson(e.data())).toList();
    });
    _database.watchWithDateTime(purchaseCollection).listen((event) {//PurchaseModelForm
      if(event.docs.isNotEmpty){
        purchaseModelList.clear();
        var memicList =  event.docs.map((e) =>PurchaseModel.fromJson(e.data())
      ).toList();
      memicList.forEach((element) {
        final matchEnrollList = enrollList.where((p0) => p0.userID == element.userId);
        final matchCarList = carLicenceFormList.where((p0) => p0.userId == element.userId);
        final matchDrivingList = drivingLicenceFormList.where((p0) => p0.userId == element.userId);
        if(matchEnrollList.isNotEmpty){
          purchaseModelList.add(element.copyWith(
            address: matchEnrollList.first.address,
          ));
        }else if(matchCarList.isNotEmpty){
          purchaseModelList.add(element.copyWith(
            address: matchEnrollList.first.address,
          ));
        }else{
          purchaseModelList.add(element.copyWith(
            address: matchEnrollList.first.address,
          ));
        }
        
      });
      }
    });
 }

  @override
  void onInit() async {
    super.onInit();
    getDeviceToken();
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    ever(items, addToExportAndBrandList);
    ever(brandItems, addToExportAndBrandList);
    sharedPref = await SharedPreferences.getInstance();
    if (getUserOrderData().isNotEmpty) {
      checkOutStep.value = 1;
    } // SharedPreference to Stroe
    
    _database.watch(rewardProductCollection).listen((event) {
      rewardProductList.value =
          event.docs.map((e) => RewardProduct.fromJson(e.data())).toList();
    });
    _database.watch(productCollection).listen((event) {
      items.value =
          event.docs.map((e) => ItemModel.fromJson(e.data(), e.id)).toList();
    });
    //For Branch Collection
    _database.watch(brandCollection).listen((event) {
      brandItems.value =
          event.docs.map((e) => ItemModel.fromJson(e.data(), e.id)).toList();
    });

    /// SIGN IN ANONYMOUSLY BECAUSE TO UPLOAD IMAGE FILE INTO FIREBASE'S STORAGE
    ///
    /// ...
    // Future<void> signInAnonymous() async {
    //   try {
    //     await FirebaseAuth.instance.signInAnonymously();
    //     debugPrint("***Signed in with temporary account.");
    //   } on FirebaseAuthException catch (e) {
    //     switch (e.code) {
    //       case "operation-not-allowed":
    //         debugPrint(
    //             "****Anonymous auth hasn't been enabled for this project.");
    //         break;
    //       default:
    //         debugPrint("***Unkown error.");
    //     }
    //   }
    // }

    _auth.onAuthChange().listen((user) async {
      if (user == null) {
        currentUser.value = AuthUser(
          id: "gustID", 
          emailAddress: "Guest",
          userName: "Guest",
          image: userImage, 
          points: 0, 
          token: "gustToken",
          status: -1,
          );
      } else {
        currentUser.value = AuthUser(
          id: "testID", 
          emailAddress: "TestEmail", 
          userName: "TestUser", 
          image: userImage, 
          points: 0, 
          token: "testToken",
          status: 0,
          );
        if (!(user == null)) {
          debugPrint("*******user is not null****");
          //we need to check document reference is already defined
          final snapshot = await FirebaseFirestore.instance
              .collection(normalUserCollection)
              .doc(user.uid)
              .get();
          if (!snapshot.exists) {
            //If not define before
            debugPrint("******Document is not exist so,we write to firebase");
            currentUser.value = 
              AuthUser(
              id: user.uid,
              emailAddress: user.email!,
              userName: user.displayName!,
              image: user.photoURL!,
              points: 0,
              token: currentUserDeviceToken.value,
              status: 0,
            );
            await _database.write(
              normalUserCollection,
              path: currentUser.value!.id,
              data: currentUser.value!.toJson(),
            );
          }else{
            await saveTokenToDatabase(currentUserDeviceToken.value);
          }

          //If user is not null,we watch this current user's document
          FirebaseFirestore.instance
              .collection(normalUserCollection)
              .doc(user.uid)
              .snapshots()
              .listen((event) {
            if (event.exists) {
              debugPrint("****UserEvent: ${event.data()}");
              currentUser.value = AuthUser.fromJson(event.data()!);
              currentUserPoint = currentUser.value!.points;
              if(currentUser.value!.status! > 0 && !alreadyWatchIfAdmin.value){
                watchOnlyIfAdmin();
              }
            }
          });
        }
      }
    });
  }

  final RxInt navIndex = 0.obs;

  void changeNav(int i) {
    navIndex.value = i;
  }

  final RxString category = 'All'.obs;
  final RxString brandCategory = 'All'.obs; //BrandCategory

  void changeCat(String name) {
    category.value = name;
  }

  //Change Brand Cat
  void changeBrandCat(String name) {
    brandCategory.value = name;
  }

  final RxBool isSearch = false.obs;

  void search() => isSearch.value = !isSearch.value;

  void onSearch(String name) {
    isSearch.value = true;
    searchitems.value = items
        .where((p0) => p0.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void clear() => isSearch.value = false;

  void searchItem(String name) {
    isSearch.value = !isSearch.value;
  }

  //Check weather show dialog or not
  showDialogToEnterPhoneCode(void Function(String code) callBack) {
    final size = MediaQuery.of(Get.context!).size;
    Get.defaultDialog(
      title: "Phone Verification",
      content: SizedBox(
        height: size.height * 0.2,
        width: size.width * 0.2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Text FIELD
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: _phoneCodeController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your code',
                  ),
                ),
              ),
              //Space
              const SizedBox(height: 10),
              //CONFIRM
              TextButton(
                onPressed: () {
                  //CALL BACK TO ORIGINAL SIGNINWITHPHONENUMBER
                  callBack(_phoneCodeController.text);
                  Get.back();
                },
                child: Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addToExportAndBrandList(List<ItemModel> callback) {
    exportAndBrandItems.value = [];
    callback.forEach((element) {
      exportAndBrandItems.add(element);
    });
  }

  /**watch reward product stream for UI performance*/
  Stream<QuerySnapshot<RewardProduct>> watchRewardProducts() =>
      FirebaseFirestore.instance
          .collection(rewardProductCollection)
          .withConverter<RewardProduct>(
            fromFirestore: (response, _) =>
                RewardProduct.fromJson(response.data()!),
            toFirestore: (rewardProduct, _) => rewardProduct.toJson(),
          )
          .snapshots();

  Future<void> signInWithGoogle(String redirectRouteUrl) async {
    showLoading();
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      hideLoading();
      Get.back();
      //Get.offNamed(redirectRouteUrl);
    } catch (e) {
      debugPrint("*******$e");
      hideLoading();
    }
  }

  Future<void> logOut() async {
    showLoading();
    Get.offAllNamed(introScreen);
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      debugPrint("*******LOGOUT Exception: $e");
    }
    hideLoading();
    currentUser.value = null;
    Get.offNamed(introScreen);
  }

  Future<void> deleteAccount() async{
    showLoading();
   await _database.delete(normalUserCollection, path: currentUser.value!.id)
    .then((value) async{
      try {
        await FirebaseAuth.instance.currentUser?.delete();
      }on FirebaseAuthException catch (e){
        if (e.code == "requires-recent-login") {
          //TODO: WE NEED TO PROMPT TO REAUTHENTICATE,then delete() again
          debugPrint("**********${e.code}");
          return;
        }
        debugPrint("**********${e.code}");
      }
    });
    hideLoading();
    currentUser.value = null;
    Get.offNamed(introScreen);
  }
}
