import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/price/cost.dart';
import 'package:uuid/uuid.dart';

import '../../../../service/database.dart';
import '../../../../widgets/show_loading/show_loading.dart';

class DLPController extends GetxController{
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Cost> cost = <Cost>[].obs;
  final _database = Database();
  var isLoading = true.obs;

  String? validate(String? value){
    if(!(value == null) && value.isNotEmpty){
      return null;
    }
    return "Fill";
  }

  Future<void> addCost() async{
   if(formKey.currentState!.validate()){
     final costData = Cost(
     id: Uuid().v1(),
     desc: descController.text, 
     cost: int.parse(priceController.text.removeAllWhitespace), 
    );
    showLoading();
    await _database.write(drivingLicenceCostCollection,
    path: costData.id,
    data: costData.toJson(),
    );
    cost.add(costData);
    hideLoading();
    priceController.clear();
    descController.clear();
   }
  }

  Future<void> deletePrice(String id) async{
    showLoading();
    await _database.delete(drivingLicenceCostCollection, 
    path: id,
    );
    cost.removeWhere((element) => element.id == id);
    hideLoading();
  }
  
  @override
  void onInit() async{
    super.onInit();
    //Request Price First Time
    _database.readCollection(drivingLicenceCostCollection)
    .then((value){
      if(value.docs.isNotEmpty){
        cost.value = value.docs.map((e) => Cost.fromJson(e.data())).toList();
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    });
    
  }
}