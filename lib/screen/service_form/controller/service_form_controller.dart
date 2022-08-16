import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/model/form/driving_licence_form.dart';
import 'package:hammies_user/service/database.dart';
import 'package:hammies_user/widgets/confirm_button.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../../data/constant.dart';
import '../../../model/price/cost.dart';
import '../../../model/radio/radio_model.dart';
import '../../../service/api.dart';

class ServiceFormController extends GetxController {
  Map<String,TextEditingController> inputMap = <String,TextEditingController>{};
  final Database _database = Database();  
      final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final HomeController _homeController = Get.find();
  var isFirstTimePress = false.obs;
  RxList<Cost> costList = <Cost>[].obs;
  var costID = "".obs;
 
  Rxn<DateTime?> selectedDateTime = Rxn<DateTime?>();

  @override
  void onInit() async{
    super.onInit();
    final result = await _database.readCollection(drivingLicenceCostCollection);
    if(result.docs.isNotEmpty){
      costList.value = result.docs.map((e) => Cost.fromJson(e.data())).toList();
    costID.value = costList[0].id;
    }
    debugPrint("*******COSTID: $costID");
  }
  
  void setCostId(String id) => costID.value = id;
  void setSelectedDateTime(DateTime dateTime) => selectedDateTime.value = dateTime;
  
 
  void pressedFirstTime() => isFirstTimePress.value = true;

   bool isValidate(){
    
    var mapNotOptional = {};
    for (var element in inputMap.entries) {
      if((element.key == "licenseNo") || (element.key == "licenseExpireDate")){
        debugPrint("**********${element.key}");
      }else{
        debugPrint("**********${element.key}");
        mapNotOptional.putIfAbsent(element.key, () => element.value);
      }
    }
    var hasErrorList = mapNotOptional.entries.where((element) => element.value.text.isEmpty).toList();
    debugPrint("***********MapNotOptionalLength: ${mapNotOptional.length}");
    if(hasErrorList.isNotEmpty){
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
    required String licenceType,
    required String serviceType,
  }) async{
    try {
      final uuID = Uuid().v1();
      final drivingModel = DrivingLicenceForm(
        id: uuID,
        cost: costList.where((e) => e.id == costID.value).first.cost,
        userId: _homeController.currentUser.value?.id ?? "",
        name: inputMap["name"]?.text ?? "", 
        fatherName: inputMap["father-name"]?.text ?? "",
         address: inputMap["adress"]?.text ?? "",
          dateOfBirth: inputMap["dateOfBirth"]?.text ?? "",
           idNo: inputMap["idNo"]?.text ?? "", 
           licenceType: licenceType, 
           phoneNumber: inputMap["phNo"]?.text ?? "", 
           serviceType: serviceType,
           licenceNo: inputMap["licenseNo"]?.text ?? "",
           licenceExpiredDate: inputMap["licenseExpireDate"]?.text ?? "",
           isConfirmed: false,
           dateTime: DateTime.now(),
           );
      if(_homeController.bankSlipImage.isNotEmpty){
         await _firebaseStorage
            .ref()
            .child("bankSlip/${drivingModel.id}")
            .putFile(File(_homeController.bankSlipImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            showLoading();
    await _database.write(
      drivingLicenceCollection,
      path: uuID,
      data: drivingModel.copyWith(bankSlipImage: value).toJson()
    ).then((value) => Api.sendPushToAdmin(
                    "လိုင်စင်",
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
 
          });});
      }else{
        showLoading();
    await _database.write(
      drivingLicenceCollection,
      path: uuID,
      data: drivingModel.toJson()
    ).then((value) => Api.sendPushToAdmin(
                    "လိုင်စင်",
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