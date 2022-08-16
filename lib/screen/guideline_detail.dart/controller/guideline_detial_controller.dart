import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/model/guideline/guideline_item.dart';
import 'package:hammies_user/service/database.dart';

class GuideLineDetailController extends GetxController{
  final HomeController _controller = Get.find();
  RxList<GuideLineItem> guideLineItemList = <GuideLineItem>[].obs;
  final _database = Database();
  var isLoading = true.obs;

  @override
  void onInit() async{
    _database.readCollectionFilter(
      guideLineItemCollection,
      filterID: _controller.parentGuideLineID.value)
    .then((value){
      if(value.docs.isNotEmpty){
        guideLineItemList.value = value.docs.map((e) => GuideLineItem.fromJson(e.data())).toList();
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    });
    super.onInit();
  }
}