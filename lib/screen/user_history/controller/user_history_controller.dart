import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/form/car_licence_form.dart';
import 'package:hammies_user/model/form/course_form.dart';
import 'package:hammies_user/service/database.dart';

import '../../../model/form/driving_licence_form.dart';
import '../../../model/purchase.dart';

class UserHistoryController extends GetxController{
  final Database _database = Database();
  final HomeController _controller  = Get.find();
  RxList<CourseForm> courseFormList = <CourseForm>[].obs;
  RxList<CarLicenceForm> carLicenceFormList = <CarLicenceForm>[].obs;
  RxList<DrivingLicenceForm> drivingLicenceFormList = <DrivingLicenceForm>[].obs;
  RxList<PurchaseModel> purchaseModelList = <PurchaseModel>[].obs;
  var isCourseLoading = true.obs;
  var isCarLoading = true.obs;
  var isDrivingLoading = true.obs;
  var isPurchaseLoading = true.obs;

  //User Address
  var userAddress = "".obs;

  @override
  void onInit() async{
    super.onInit();
    //CourseEnrollment
    FirebaseFirestore.instance.collection(courseFormCollection)
    .where("userID", isEqualTo: _controller.currentUser.value?.id)
    .get()
    .then((value){
      isCourseLoading.value = false;
      courseFormList.value = value.docs.map((e) => CourseForm.fromJson(e.data())).toList();
      if(courseFormList.isNotEmpty){
        userAddress.value = courseFormList[0].address;
      }
    });
    //CarLicence
    FirebaseFirestore.instance.collection(carLicenceCollection)
    .where("userId", isEqualTo: _controller.currentUser.value?.id)
    .get()
    .then((value){
      isCarLoading.value = false;
      carLicenceFormList.value = value.docs.map((e) => CarLicenceForm.fromJson(e.data())).toList();
      if(carLicenceFormList.isNotEmpty){
        userAddress.value = carLicenceFormList[0].address;
      }
    });
    //DrivingLicence
    FirebaseFirestore.instance.collection(drivingLicenceCollection)
    .where("userId", isEqualTo: _controller.currentUser.value?.id)
    .get()
    .then((value){
      isDrivingLoading.value = false;
      drivingLicenceFormList.value = value.docs.map((e) => DrivingLicenceForm.fromJson(e.data())).toList();
      if(drivingLicenceFormList.isNotEmpty){
        userAddress.value = drivingLicenceFormList[0].address;
      }
    });

    //PurchaseModel
    FirebaseFirestore.instance.collection(purchaseCollection)
    .where("userId", isEqualTo: _controller.currentUser.value?.id)
    .get()
    .then((value){
      isPurchaseLoading.value = false;
      purchaseModelList.value = value.docs.map((e) => PurchaseModel.fromJson(e.data())
      .copyWith(address: userAddress.value)
      ).toList();
    });
  }
}