import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/driving_licence_price/controller/dlp_controller.dart';

class DLPBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DLPController());
  }

}