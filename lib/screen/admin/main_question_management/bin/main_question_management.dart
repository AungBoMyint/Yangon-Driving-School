import 'package:get/get.dart';

import '../controller/main_question_controller.dart';

class MainQuestionManagement extends Bindings {
  @override
  void dependencies() {
   Get.put(MainQuestionManagementController());
  }
  
}