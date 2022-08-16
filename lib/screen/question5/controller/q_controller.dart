import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/question/sub_question.dart';
import 'package:hammies_user/service/database.dart';

import '../../../../model/question/question.dart';

class QuestionTabController extends GetxController{
  Rxn<SplayTreeMap<int,Question>> mainQuestionMap = Rxn<SplayTreeMap<int,Question>>(SplayTreeMap<int,Question>());
  RxList<Question> mainQuestionList = <Question>[].obs;
  Rxn<SplayTreeMap<int,SplayTreeMap<int,SubQuestion>>> subQuestionMap = Rxn<SplayTreeMap<int,SplayTreeMap<int,SubQuestion>>>(
    SplayTreeMap<int,SplayTreeMap<int,SubQuestion>>()
  );
  final Database _database = Database();
  var isLoading = true.obs;
  var mainTabLoading = true.obs;
  var isSubTabLoading = true.obs;

  

  void setExpandedOrCollapsed(int mainIndex,int subIndex,bool value){
   subQuestionMap.value![mainIndex]![subIndex] = subQuestionMap.value![mainIndex]![subIndex]!.copyWith(
    isExpanable: !value,
   );
   subQuestionMap.update((val) { 
    subQuestionMap.value![mainIndex]![subIndex] = subQuestionMap.value![mainIndex]![subIndex]!.copyWith(
    isExpanable: !value,
   );
   });
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
      mainTabLoading.value = false;
      debugPrint("********ManTabList: ${mainQuestionList.length}");
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
          subQuestionMap.update((obj) => subQuestionMap.value!.putIfAbsent(question.qNo, () {
            SplayTreeMap<int,SubQuestion> resultMap = SplayTreeMap<int,SubQuestion>();
            subQuestionList.forEach((element) {
              resultMap.putIfAbsent(element.qNo, () => element.copyWith(mainQNo: question.qNo));
            });
            return resultMap;
          }));
          if(subQuestionMap.value!.length == mainQuestionList.length){
            isSubTabLoading.value = false;
          }
        });
      });
      isLoading.value = false;
      debugPrint("*************SubQuestionMap: ${subQuestionMap.value?.length}");
    });
    
  }
}

