import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/form/car_licence_form.dart';
import 'package:hammies_user/service/database.dart';
import 'package:hammies_user/widgets/confirm_button.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../model/price/cost.dart';
import '../../../service/api.dart';

class CarLicenseController extends GetxController {
  Map<String,TextEditingController> inputMap = <String,TextEditingController>{};
  final HomeController _homeController = Get.find();
  Map<String,dynamic> radioMap = <String,dynamic>{};
  final Database _database = Database();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  var isFirstTimePress = false.obs;
  RxList<Cost> costList = <Cost>[].obs;
  var costID = "".obs;
  Rxn<DateTime?> selectedDateTime = Rxn<DateTime?>();

  @override
  void onInit() async{
    super.onInit();
    final result = await _database.readCollection(carLicenceCostCollection);
    if(result.docs.isNotEmpty){
      costList.value = result.docs.map((e) => Cost.fromJson(e.data())).toList();
    costID.value = costList[0].id;
    }
    debugPrint("*******COSTID: $costID");
  }
  

  void setCostId(String id) => costID.value = id;
  void setSelectedDateTime(DateTime dateTime) => selectedDateTime.value = dateTime;
  
  /* void changeTimeType(TimeType value) => timeType.value = value;
  void changeDayType(DayType value) => dayType.value = value;
  void changeClassType(ClassType value) => classType.value = value;
  void changeCarType(CarType value) => carType.value = value; */
  void pressedFirstTime() => isFirstTimePress.value = true;

   bool isValidate(){
    var hasErrorList = inputMap.entries.where((element) => element.value.text.isEmpty).toList();
    if(hasErrorList.isNotEmpty ){
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

  Future<void> submitForm({
    required String enginPowerType,
  }) async{
    try {
      final uuID = Uuid().v1();
      final carModel = CarLicenceForm(
        id: uuID,
        cost: costList.where((e) => e.id == costID.value).first.cost,
        userId: _homeController.currentUser.value?.id ?? "",
        name: inputMap["name"]?.text ?? "", 
        address: inputMap["adress"]?.text ?? "", 
        carExpiredDate: inputMap["expireDate"]?.text ?? "", 
        carNo: inputMap["carNo"]?.text ?? "", 
        enginPowerType: enginPowerType, 
        idNo: inputMap["idNo"]?.text ?? "", 
        phoneNumber: inputMap["phNo"]?.text ?? "", 
        isConfirmed: false,
        dateTime: DateTime.now(), 
        toDoFromOffice: inputMap["toDoFromOffice"]?.text ?? "",
        );
      showLoading();
       if (_homeController.bankSlipImage.isNotEmpty) {
        await _firebaseStorage
            .ref()
            .child("bankSlip/${carModel.id}")
            .putFile(File(_homeController.bankSlipImage.value))
            .then((snapshot) async{
              await snapshot.ref.getDownloadURL()
              .then((value) async{
                 await _database.write(
      carLicenceCollection,
      path: uuID,
      data: carModel.copyWith(
        bankSlipImage: value,
      ).toJson(),
    ).then((value) => Api.sendPushToAdmin(
                    "ကားလိုင်စင်",
                    "🧑အမည်:${inputMap["name"]?.text ?? ""}\n"
                        "🏠လိပ်စာ: ${inputMap["adress"]?.text ?? ""}\n"
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
                                  "We will notify to you when admin confirm your form.",
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
                                    await _database.write(
                                  carLicenceCollection,
                                  path: uuID,
                                  data: carModel.toJson(),
    ).then((value) => Api.sendPushToAdmin(
                    "ကားလိုင်စင်",
                    "🧑အမည်:${inputMap["name"]?.text ?? ""}\n"
                        "🏠လိပ်စာ: ${inputMap["adress"]?.text ?? ""}\n"
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
      "We will notify to you when admin confirm your form.",
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
}