import 'package:get/get.dart';
import 'package:cipher_guard/controllers/encryptions_controller.dart';

class EncryptionsBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<EncryptionsController>(EncryptionsController());
  }

}