import 'package:get/get.dart';

import '../controller/gc_controller.dart';

class GCBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GCController());
  }
  
}