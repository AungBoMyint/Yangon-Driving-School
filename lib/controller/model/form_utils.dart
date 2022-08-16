import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class RxFormClass {
 bool? isFirstTimePress;
  RxFormClass({this.isFirstTimePress = false});
  final TextEditingController controller = TextEditingController();
  var hasError = false.obs;
  

  void changingInput(String? value){
    if(isFirstTimePress! && (
      (value == null) || value.isEmpty
    )){
      hasError.value = true;
    }else{
      hasError.value = false;
    }
  }


}