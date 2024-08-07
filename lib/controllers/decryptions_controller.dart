import 'package:get/get.dart';
import 'package:cipher_guard/controllers/app_service.dart';
import 'package:cipher_guard/database/users.dart';

class DecryptionsController extends GetxController {
  DecryptionsController() {
    app = Get.find<AppService>();
    getAll();
  }

  late final AppService app;
  late List<Decryption> decList;
  late RxBool isLoaded = RxBool(false);

  Future<void> getAll() async {
    decList = await app.getAllDecryptions(app.currentUser!.id);
    isLoaded.value = true;
  }

  String getDate(DateTime dateTime) {
    return "${dateTime.day}/ ${dateTime.month}/ ${dateTime.year}";
  }
}
