import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/controllers/app_service.dart';
import 'package:cipher_guard/database/users.dart';

class LoginController extends GetxController {
  LoginController() {
    app = Get.find<AppService>();
  }

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  User? tempUser;
  late Rx<Widget> user = Rx(const Text(
    "please search for your user or try to signup",
    style: TextStyle(color: Colors.white54),
  ));
  late RxBool? firstValidate;
  late RxBool? lastValidate;
  late RxBool? passValidate;
  late RxBool isLogin = RxBool(true);
  late final AppService app;

  void iniControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    firstValidate = RxBool(false);
    lastValidate = RxBool(false);
    passValidate = RxBool(false);
  }

  Future<void> createUser() async {
    await app.createUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text);
    app.currentUser = await app.getUser(
        firstName: firstNameController.text, lastName: lastNameController.text);
    Get.offAllNamed("/");
  }

  void getUser(int id) async {
    tempUser = await app.getUserById(id);
    user.value = ListTile(
      title: Text(
        "welcome ${tempUser!.firstName.capitalize} ${tempUser!.lastName.capitalize} please insert your password",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void login(User user) {
    app.currentUser = user;
    Get.offAllNamed("/");
  }
}
