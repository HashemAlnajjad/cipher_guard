import 'package:get/get.dart';
import 'package:cipher_guard/controllers/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
