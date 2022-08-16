import 'package:get/get.dart';

import '../controller/enrollment_controller.dart';

class EnrollmentBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(EnrollmentController());
  }

}