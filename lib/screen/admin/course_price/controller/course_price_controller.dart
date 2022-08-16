import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../../model/price/price.dart';
import '../../../../service/database.dart';

class CoursePriceController extends GetxController{
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Price> priceList = <Price>[].obs;
  final _database = Database();
  var isLoading = true.obs;

  String? validate(String? value){
    if(!(value == null) && value.isNotEmpty){
      return null;
    }
    return "Fill";
  }

  Future<void> addPrice() async{
   if(formKey.currentState!.validate()){
     final price = Price(id: Uuid().v1(),
     desc: descController.text, 
    price: int.parse(priceController.text.removeAllWhitespace), 
    dateTime: DateTime.now(),
    );
    showLoading();
    await _database.write(coursePriceCollection,
    path: price.id,
    data: price.toJson(),
    );
    priceList.add(price);
    //priceList[priceList.length + 1] = price;
    hideLoading();
    priceController.clear();
    descController.clear();
   }
  }

  Future<void> deletePrice(String id) async{
    showLoading();
    await _database.delete(coursePriceCollection, 
    path: id,
    );
    priceList.removeWhere((e) => e.id == id);
    hideLoading();
  }
  
  @override
  void onInit() async{
    super.onInit();
    //Request Price First Time
    _database.readCollection(coursePriceCollection)
    .then((value){
      if(value.docs.isNotEmpty){
        priceList.value = value.docs.map((e) => Price.fromJson(e.data())).toList();
        isLoading.value = false;
      }
    });
  }
}