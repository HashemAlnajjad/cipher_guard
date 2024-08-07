import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/bindings/decryptions_bindings.dart';
import 'package:cipher_guard/screens/decryptions_screen.dart';
import 'package:cipher_guard/screens/encryptions_screen.dart';
import 'package:cipher_guard/screens/login_screen.dart';
import 'package:cipher_guard/screens/main_screen.dart';
import 'bindings/app_service_bindings.dart';
import 'bindings/encryptions_bindings.dart';
import 'bindings/login_bindings.dart';
import 'bindings/main_screen_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        initialBinding: AppServiceBindings(),
        getPages: [
          GetPage(
              name: "/",
              page: () => const MainScreen(),
              binding: MainScreenBindings()),
          GetPage(
              name: "/login",
              page: () => const LoginScreen(),
              binding: LoginBindings()),
          GetPage(
              name: "/encryptions",
              page: () => const EncryptionsScreen(),
              binding: EncryptionsBindings()),
          GetPage(
              name: "/decryptions",
              page: () => const DecryptionsScreen(),
              binding: DecryptionsBindings()),
        ]);
  }
}
