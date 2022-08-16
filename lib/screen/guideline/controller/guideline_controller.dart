import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/guideline/guideline_category.dart';

import '../../../../service/database.dart';

class GuideLineController extends GetxController{
  final _database = Database();
  var isLoading = true.obs;
  RxList<GuideLineCategory> guideLineCategoriesList = <GuideLineCategory>[].obs;

  @override
  void onInit() async{
     _database.readCollection(guideLineCategoryCollection)
    .then((value){
      if(value.docs.isNotEmpty){
        guideLineCategoriesList.value = value.docs.map((e) => GuideLineCategory.fromJson(e.data()))
        .toList();
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    });
    super.onInit();
  }
}