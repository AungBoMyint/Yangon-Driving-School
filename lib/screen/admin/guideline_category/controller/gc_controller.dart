import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/colorpicker.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/guideline/guideline_category.dart';
import 'package:hammies_user/service/database.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class GCController extends GetxController{
  final _database = Database();
  var isLoading = true.obs;
  var isFirstTimePress = false.obs;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String,TextEditingController> inputMap = <String,TextEditingController>{};

  var pickedColor = redColor.obs;
  RxList<GuideLineCategory> guideLineCategories = <GuideLineCategory>[].obs;


  @override
  void onInit() {
    //We only listen in this view,else dispose
    _database.watchWithDateTime(guideLineCategoryCollection)
    .listen((event) {
      if(event.docs.isNotEmpty){
        guideLineCategories.value = event.docs.map((e) => GuideLineCategory.fromJson(e.data())).toList();
        isLoading.value = false;
      }
      else{
        isLoading.value = false;
      }
    });
    super.onInit();
  }

  Future<void> uploadGLC() async{
   
      showLoading();
     final gc = GuideLineCategory(
      id: Uuid().v1(),
      title: inputMap["title"]?.text ?? "",
      image: inputMap["image"]?.text ?? "",
      color: pickedColor.value,
      dateTime: DateTime.now(),
      );
    
    await _database.write(guideLineCategoryCollection,
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
    await _database.delete(guideLineCategoryCollection, 
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

  void setPickedColor(String color){
    pickedColor.value = color;
  }

  Future<void> colorPicker() async{
    Get.defaultDialog(
      title: "",
      content: Obx((){
        return Wrap(
          children: colorList.map((e){
            return Container(
              height: 50,
              width: 50,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => setPickedColor(e),
                      splashColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: HexColor(e),
                      ),
                    ),
                  ),

                  pickedColor.value == e ?
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                  )
                  : const SizedBox(),
                ]
              )
            );
          }).toList(),
        );
      })
    );
  }
}