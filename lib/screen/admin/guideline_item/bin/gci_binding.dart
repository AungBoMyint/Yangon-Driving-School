import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/guideline_item/controller/gci_controller.dart';

class GCIBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GCIController());
  }
  
}