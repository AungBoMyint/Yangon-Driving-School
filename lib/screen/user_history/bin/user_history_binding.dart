import 'package:get/get.dart';
import 'package:hammies_user/screen/user_history/controller/user_history_controller.dart';

class UserHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserHistoryController());
  }
  
}