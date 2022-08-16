import 'package:get/get.dart';

import '../controller/clp_controller.dart';

class CLPBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(CLPController());
  }

}