import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/question_form/controller/question_form_controller.dart';

class QuestionFormBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(QuestionFormController());
  }

}