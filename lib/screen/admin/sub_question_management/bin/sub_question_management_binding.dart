import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/sub_question_management/controller/sub_question_controller.dart';

class SubQuestionManagementBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(SubQuestionManagementController());
  }
}