import 'package:get/get.dart';
import '../controller/course_form_controller.dart';

class CourseFormBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CourseFormController());
  }
  
}