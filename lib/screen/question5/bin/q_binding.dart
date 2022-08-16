import 'package:get/get.dart';
import 'package:hammies_user/screen/question5/controller/q_controller.dart';

class QuestionTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(QuestionTabController());
  }
}