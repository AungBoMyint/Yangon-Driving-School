import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/colorpicker.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/guideline/guideline_category.dart';
import 'package:hammies_user/model/guideline/guideline_item.dart';
import 'package:hammies_user/service/database.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class GCIController extends GetxController{
  final _database = Database();
  var isLoading = true.obs;
  var isFirstTimePress = false.obs;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String,TextEditingController> inputMap = <String,TextEditingController>{};

  RxList<GuideLineCategory> guideLineCategories = <GuideLineCategory>[].obs;
  RxList<GuideLineItem> guideLineItems = <GuideLineItem>[].obs;

  var selectedCategory = "".obs;

  @override
  void onInit() {
    
    _database.readCollection(guideLineCategoryCollection)
    .then((value){
      if(value.docs.isNotEmpty){
        guideLineCategories.value = value.docs.map((e) => GuideLineCategory.fromJson(e.data())).toList();
        
        selectedCategory.value = guideLineCategories[0].id;
      }
    });

    //We only listen in this view,else dispose
    _database.watchWithDateTime(guideLineItemCollection)
    .listen((event) {
      guideLineItems.value = event.docs.map((e) => GuideLineItem.fromJson(e.data())).toList();
      isLoading.value = false;
    });
    
    super.onInit();
  }

  Future<void> uploadGLC() async{
   
      showLoading();
     final gc = GuideLineItem(
      id: Uuid().v1(),
      parentId: selectedCategory.value,
      desc: inputMap["title"]?.text ?? "",
      image: inputMap["image"]?.text ?? "",
      dateTime: DateTime.now(),
      );
    
    await _database.write(guideLineItemCollection,
    path: gc.id,
    data: gc.toJson(),
    );
    hideLoading();
    inputMap["title"]?.text = "";
    inputMap["image"]?.text = "";
    isFirstTimePress.value = false;
   
  }

   Future<void> deleteGC(String id) async{
    showLoading();
    await _database.delete(guideLineItemCollection, 
    path: id,
    );
    hideLoading();
  }
  void pressedFirstTime() => isFirstTimePress.value = true;
  bool checkHasError(String fieldKey,String? value){

    if(
      (inputMap[fieldKey]!.value.text.isEmpty)
      && isFirstTimePress.value){
      return true;
    }else{
      return false;
    }
  }

  bool isValidate(){
    var hasErrorList = inputMap.entries.where((element) => element.value.text.isEmpty).toList();
    if(hasErrorList.isNotEmpty){
      return false;
    }else{
      return true;
    }
  }

  void setSelectedCategory(String color){
    selectedCategory.value = color;
  }

}