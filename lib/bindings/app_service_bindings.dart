import 'package:get/get.dart';
import 'package:cipher_guard/controllers/app_service.dart';

class AppServiceBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AppService>(AppService());
  }
}
