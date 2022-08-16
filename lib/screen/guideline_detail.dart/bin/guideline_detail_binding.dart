import 'package:get/get.dart';
import 'package:hammies_user/screen/guideline_detail.dart/controller/guideline_detial_controller.dart';

class GuideLineDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GuideLineDetailController());
  }
  
}