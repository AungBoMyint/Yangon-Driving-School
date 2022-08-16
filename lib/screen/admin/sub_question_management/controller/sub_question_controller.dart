import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/question/sub_question.dart';
import 'package:hammies_user/screen/admin/question_form/controller/question_form_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../../service/database.dart';
import '../../../../widgets/show_loading/show_loading.dart';

class SubQuestionManagementController extends GetxController{
   Map<String,TextEditingController> inputMap = <String,TextEditingController>{};
  var isFirstTimePress = false.obs;
  final Database _database = Database();
  final HomeController _homeController = Get.find();
  final QuestionFormController _questionController = Get.find();
  bool isValidate(){
    
    var mapNotOptional = {};
    for (var element in inputMap.entries) {
      if((element.key == "title")){
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

  void pressedFirstTime() => isFirstTimePress.value = true;

  Future<void> newOrUpdateMainQuestion()async{
    try {
      final subQuestion = SubQuestion(
        id: _homeController.editSubQuestion.value?.id ?? Uuid().v1(), 
        qNo: int.parse(inputMap["qNo"]?.text ?? ""), 
        title: inputMap["title"]?.text ?? "",
        description: inputMap["description"]?.text ?? "",
        answer: inputMap["answer"]?.text ?? "",
        dateTime: _homeController.editSubQuestion.value?.dateTime ?? DateTime.now(),
        );
      showLoading();
      await _database.writeSubCollection(
      mainCollection: mainQuestionCollection,
      mainPath: _homeController.mainQuestion.value?.id ?? "",
      subCollection: subQuestionCollection,
      subPath: subQuestion.id,
      data: subQuestion.toJson());
        hideLoading();
          Get.snackbar("Success", "",duration: const Duration(seconds: 1));
      
      //Dummy Data
      if(_homeController.editSubQuestion.value == null){
      _questionController.subQuestionMap.value![
        _homeController.mainQuestion.value!.qNo
      ]?.putIfAbsent(subQuestion.qNo, () => subQuestion);
      _questionController.subQuestionMap.refresh();
      }else{
        _questionController.subQuestionMap.value![
        _homeController.mainQuestion.value!.qNo
      ]?.removeWhere((key, value) => key == _homeController.editSubQuestion.value?.qNo);
      _questionController.subQuestionMap.value![
        _homeController.mainQuestion.value!.qNo
      ]?[subQuestion.qNo] =  subQuestion;
      _questionController.subQuestionMap.refresh();
      }
       Future.delayed(const Duration(seconds: 1), () => Navigator.pop(Get.context!));
    } catch (e) {
       Get.snackbar("Failed!", "Try again.");
      debugPrint("**********$e");
    }
  }

}