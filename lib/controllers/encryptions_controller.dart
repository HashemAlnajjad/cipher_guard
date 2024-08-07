import 'package:get/get.dart';
import 'package:cipher_guard/controllers/app_service.dart';
import 'package:cipher_guard/database/users.dart';

class EncryptionsController extends GetxController {
  EncryptionsController() {
    app = Get.find<AppService>();
    getAll();
  }

  late final AppService app;
  late List<Encryption> encList;
  late RxBool isLoaded = RxBool(false);

  Future<void> getAll() async {
    encList = await app.getAllEncryptions(app.currentUser!.id);
    isLoaded.value = true;
  }

  String getDate(DateTime dateTime) {
    return "${dateTime.day}/ ${dateTime.month}/ ${dateTime.year}";
  }
}
