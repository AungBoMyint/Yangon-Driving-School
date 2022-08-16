import 'package:get/get.dart';

import '../controller/guideline_controller.dart';

class GuideLineBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GuideLineController());
  }
  
}