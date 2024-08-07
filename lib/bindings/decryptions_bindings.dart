import 'package:get/get.dart';
import 'package:cipher_guard/controllers/decryptions_controller.dart';

class DecryptionsBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<DecryptionsController>(DecryptionsController());
  }

}