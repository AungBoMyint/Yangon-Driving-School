import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/service/database.dart';
import 'package:hammies_user/widgets/confirm_button.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../../data/constant.dart';
import '../../../model/form/course_form.dart';
import '../../../model/price/price.dart';
import '../../../service/api.dart';

class CourseFormController extends GetxController {
  Map<String,TextEditingController> inputMap = <String,TextEditingController>{};
  final HomeController _homeController = Get.find();
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Map<String,dynamic> radioMap = <String,dynamic>{};
  RxList<Price> priceList = <Price>[].obs;
  var priceID = "".obs;
  final Database _database = Database();
  var isFirstTimePress = false.obs;
  var dayType = "".obs;
  /* var classType = ClassType.home.obs;
  var carType = CarType.auto.obs;
  var dayType = DayType.normalDays.obs;
  var timeType = TimeType.morning.obs; */
  Rxn<DateTime?> selectedDateTime = Rxn<DateTime?>();
  void changePriceID(String id) => priceID.value = id;
  void setSelectedDateTime(DateTime dateTime) => selectedDateTime.value = dateTime;
  void changeDayType(String value) => dayType.value = value;
 /*  void changeTimeType(TimeType value) => timeType.value = value;
  void changeDayType(DayType value) => dayType.value = value;
  void changeClassType(ClassType value) => classType.value = value;
  void changeCarType(CarType value) => carType.value = value; */
  void pressedFirstTime() => isFirstTimePress.value = true;

   bool isValidate(){
    var hasErrorList = inputMap.entries.where((element) => element.value.text.isEmpty).toList();
    if(hasErrorList.isNotEmpty || selectedDateTime.value == null){
      return false;
    }else{
      return true;
    }
  }

  bool checkHasError(String fieldKey,String? value){

    if(
      (inputMap[fieldKey]!.value.text.isEmpty)
      && isFirstTimePress.value){
      return true;
    }else{
      return false;
    }
  }

submitForm({
    required String carType,
    required String courseType,
    required String dayType,
    required String timeType,
  }) async{
    try {
      final uuId =  Uuid().v1();
      final courseModel = CourseForm(
        id: uuId,
        isConfirmed: false,
        name: inputMap["name"]?.text ?? "", 
        fatherName: inputMap["father-name"]?.text ?? "",
         address: inputMap["adress"]?.text ?? "", 
         carType: carType, 
         courseType: courseType,
          dayType: dayType, 
          idNo: inputMap["idNo"]?.text ?? "", 
          initialDay: selectedDateTime.value ?? DateTime.now(), 
          phoneNumber: inputMap["phNo"]?.text ?? "",
           timeType: timeType,
           price: priceList.where((e) => e.id == priceID.value).first,
           userID: _homeController.currentUser.value?.id ?? "",
           dateTime: DateTime.now(),
           );
      if(_homeController.bankSlipImage.isNotEmpty){
         await _firebaseStorage
            .ref()
            .child("bankSlip/${courseModel.id}")
            .putFile(File(_homeController.bankSlipImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
             showLoading();
      await Future.delayed(const Duration(seconds: 0));
     _database.write(courseFormCollection,path: uuId, data: 
      
      courseModel.copyWith(bankSlipImage: value).toJson()
    ).then((value) => Api.sendPushToAdmin(
                    "သင်တန်းအပ်ခြင်း",
                    "🧑 အမည်:${inputMap["name"]?.text ?? ""}\n"
                        "🏠 လိပ်စာ: ${inputMap["address"]?.text ?? ""}\n"
                        "✍ ဖုန်း: ${inputMap["phNo"]?.text ?? ""}"))
                        .then((value) async{ 
                           hideLoading();
     Get.snackbar("Success", "",duration: const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(Get.context!);
                          Get.defaultDialog(
    title: "Success",
    titleStyle: const TextStyle(color: Colors.black),
    
    
    content:  Text(
      "We will notify to you when admin confirm your enrollment.",
      style:const  TextStyle(color: Colors.black),
      ),
    onConfirm: () => Get.back(),
    confirm: confirmButton(),
                    confirmTextColor: Colors.white,
                    barrierDismissible: false,
                    buttonColor: Colors.transparent,
                    radius: 10,
                  );
                        });
   
          });
            });
      }else{
         showLoading();
      await Future.delayed(const Duration(seconds: 0));
     _database.write(courseFormCollection,path: uuId, data: 
      
      courseModel.toJson()
    ).then((value) => Api.sendPushToAdmin(
                    "သင်တန်းအပ်ခြင်း",
                    "🧑အမည်:${inputMap["name"]?.text ?? ""}\n"
                        "🏠လိပ်စာ: ${inputMap["address"]?.text ?? ""}\n"
                        "✍ဖုန်း: ${inputMap["phNo"]?.text ?? ""}"))
                        .then((value) async{ 
                           hideLoading();
     Get.snackbar("Success", "",duration: const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(Get.context!);
                          Get.defaultDialog(
    title: "Success",
    titleStyle: const TextStyle(color: Colors.black),
    
    
    content:  Text(
      "We will notify to you when admin confirm your enrollment.",
      style:const  TextStyle(color: Colors.black),
      ),
    onConfirm: () => Get.back(),
    confirm: confirmButton(),
                    confirmTextColor: Colors.white,
                    barrierDismissible: false,
                    buttonColor: Colors.transparent,
                    radius: 10,
                  );
                        });
   
      }
     
    } catch (e) {
      Get.snackbar("Failed!", "Try again.");
      debugPrint("**********$e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    //Request Price First Time
    _database.readCollection(coursePriceCollection)
    .then((value){
      if(value.docs.isNotEmpty){
        priceList.value = value.docs.map((e) => Price.fromJson(e.data())).toList();
        priceID.value = priceList[0].id;
      }
    });
  }
}