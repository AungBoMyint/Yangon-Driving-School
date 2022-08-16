import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/question/sub_question.dart';
import 'package:hammies_user/service/database.dart';

import '../../../../model/question/question.dart';
import '../../../../widgets/show_loading/show_loading.dart';

class QuestionFormController extends GetxController{
  Rxn<SplayTreeMap<int,Question>> mainQuestionMap = Rxn<SplayTreeMap<int,Question>>(SplayTreeMap<int,Question>());
  RxList<Question> mainQuestionList = <Question>[].obs;
  Rxn<SplayTreeMap<int,SplayTreeMap<int,SubQuestion>>> subQuestionMap = Rxn<SplayTreeMap<int,SplayTreeMap<int,SubQuestion>>>(
    SplayTreeMap<int,SplayTreeMap<int,SubQuestion>>()
  );
  final Database _database = Database();
  var isLoading = true.obs;

  

  void setExpandedOrCollapsed(int index,bool value){
    mainQuestionList[index] = mainQuestionList[index].copyWith(isExpanded: !value);
  }

  void changeExpandOrCollapse(int index,bool value){
    mainQuestionList[index] = mainQuestionList[index]
    .copyWith();
  }

  Future<void> deleteMain(Question q) async{
    showLoading();
    await _database.delete(mainQuestionCollection, path: q.id);
    hideLoading();
    mainQuestionMap.value?.remove(q.qNo);
    mainQuestionList.removeWhere((element) => element.id == q.id);
    mainQuestionList.refresh();
    subQuestionMap.value?.remove(q.qNo);
    subQuestionMap.refresh();
   Future.delayed(const Duration(seconds: 1), () => Get.back());
  }
  Future<void> deleteSubQuestion(Question q,SubQuestion sQ)async{
    showLoading();
    await _database.delete("$mainQuestionCollection/${q.id}/$subQuestionCollection", path: sQ.id);
    hideLoading();
    subQuestionMap.value?.remove(q.qNo);
    subQuestionMap.refresh();
      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(Get.context!));
  }
  @override
  void onInit() async{
    super.onInit();
    _database.readCollection(mainQuestionCollection)
    .then((value) async{
      debugPrint("**********************$value");
      //Looping and insert to Main SplayTreeMap
      SplayTreeMap<int, Question> memicMainQuestion = SplayTreeMap<int, Question>();
      value.docs.forEach((element) {
        final question = Question.fromJson(element.data());
        memicMainQuestion.putIfAbsent(question.qNo, () => question);
      });
      mainQuestionMap.value = memicMainQuestion;
      mainQuestionList.value = memicMainQuestion.entries.map((e) => e.value).toList();
      isLoading.value = false;

      //Looping and inset to sub SplayTreeMap
      value.docs.forEach((element) {
        final question = Question.fromJson(element.data());
        _database.readSubCollection(
          mainCollectionPath: mainQuestionCollection,
          mainPath: question.id,
          subCollectionPath: subQuestionCollection,
        )
        .then((value){
          final subQuestionList = value.docs.map((e) => SubQuestion.fromJson(e.data())).toList();
          subQuestionMap.value!.putIfAbsent(question.qNo, () {
            SplayTreeMap<int,SubQuestion> resultMap = SplayTreeMap<int,SubQuestion>();
            subQuestionList.forEach((element) {
              resultMap.putIfAbsent(element.qNo, () => element);
            });
            return resultMap;
          });
          debugPrint("*****Sub Question List: ${subQuestionList.length}");
        });
      });
    });
    
  }
}

