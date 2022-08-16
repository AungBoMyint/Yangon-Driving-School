import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/view/cart.dart';
import 'package:intl/intl.dart';

Map<String,dynamic> inputMap = {};

String getDate(DateTime date){
  return DateFormat.yMMMMEEEEd().format(date);
}

/* void showCustomButtonSheet(/* Future<void> callback */){
  Get.bottomSheet(
    PaymentOptionContent(/* callback: callback, */),
    backgroundColor: Colors.white,
    barrierColor: Colors.white.withOpacity(0),
    elevation: 2,
  );
} */