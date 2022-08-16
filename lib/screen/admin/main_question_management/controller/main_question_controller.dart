import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/model/question/question.dart';
import 'package:hammies_user/service/database.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/constant.dart';
import '../../question_form/controller/question_form_controller.dart';

class MainQuestionManagementController extends GetxController {
  Map<String,TextEditingController> inputMap = <String,TextEditingController>{};
  var isFirstTimePress = false.obs;
  final Database _database = Database();
  final QuestionFormController _qController = Get.find();
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

  Future<void> newOrUpdateMainQuestion(String? id)async{
    try {
      final question = Question(
        id: id ?? Uuid().v1(), 
        qNo: int.parse(inputMap["qNo"]?.text ?? ""), 
        title: inputMap["title"]?.text ?? "",
        isExpanded: false,
        );
      showLoading();
      await _database.write(mainQuestionCollection, 
      data: question.toJson(),
      path: question.id,
      );
        hideLoading();
          Get.snackbar("Success", "",duration: const Duration(seconds: 1));
          //Dummy and Refresh
          if(id == null){
            _qController.mainQuestionMap.value?.putIfAbsent(question.qNo, () => question);
            _qController.mainQuestionList.value = _qController.mainQuestionMap.value?.entries.map((e) => e.value).toList() ?? [];
            _qController.mainQuestionList.refresh();
          }else{
            _qController.mainQuestionMap.value?.removeWhere((key, value) => value.id == id);
            _qController.mainQuestionMap.value?[question.qNo] =  question;
            _qController.mainQuestionList.value = _qController.mainQuestionMap.value?.entries.map((e) => e.value).toList() ?? [];
            _qController.mainQuestionList.refresh();
          }
          //
      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(Get.context!));
    } catch (e) {
       Get.snackbar("Failed!", "Try again.");
      debugPrint("**********$e");
    }
  }

}