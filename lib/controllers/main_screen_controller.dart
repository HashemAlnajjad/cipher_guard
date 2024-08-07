import 'package:get/get.dart';
import 'package:cipher_guard/controllers/app_service.dart';

class MainScreenController extends GetxController {
  MainScreenController() {
    app = Get.find<AppService>();
  }

  late final AppService app;

  void logOut() {
    app.currentUser = null;
  }
}
