import 'package:get/get.dart';

import '../controller/course_price_controller.dart';

class CoursePriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CoursePriceController());
  }
  
}