import 'package:get/get.dart';
import 'package:hammies_user/screen/service_form/controller/service_form_controller.dart';

class ServiceFormBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ServiceFormController());
  }
  
}