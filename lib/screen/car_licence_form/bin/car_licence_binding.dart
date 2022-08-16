import 'package:get/get.dart';

import '../controller/car_license_controller.dart';

class CarLicenseService extends Bindings{
  @override
  void dependencies() {
    Get.put(CarLicenseController());
  }
  
}