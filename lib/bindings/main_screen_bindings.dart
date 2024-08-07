import 'package:get/get.dart';
import 'package:cipher_guard/controllers/main_screen_controller.dart';

class MainScreenBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<MainScreenController>(MainScreenController());
  }

}