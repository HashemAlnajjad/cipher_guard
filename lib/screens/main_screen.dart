import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/controllers/main_screen_controller.dart';
import 'package:cipher_guard/taps/decryption_screen.dart';
import 'package:cipher_guard/taps/encryption_screen.dart';
import 'package:cipher_guard/widgets/my_button.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[900],
          ),
          drawer: Drawer(
            backgroundColor: Colors.grey[900],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      DrawerHeader(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          "${controller.app.currentUser!.firstName.capitalize} ${controller.app.currentUser!.lastName.capitalize}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      MyButton(
                          onTap: () {
                            Get.toNamed("/encryptions");
                          },
                          label: "Encryptions"),
                      MyButton(
                          onTap: () {
                            Get.toNamed("/decryptions");
                          },
                          label: "Decryptions"),
                    ]),
                    Container(
                        margin: const EdgeInsets.all(24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                foregroundColor: Colors.teal,
                                tooltip: "LogOut",
                                onPressed: () {
                                  controller.logOut();
                                  Get.offAllNamed("/login");
                                },
                                child: const Icon(Icons.logout),
                              ),
                            ]))
                  ])),
          body: TabBarView(
            children: [
              EncryptionPage(),
              DecryptionPage(),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TabBar(
                      labelStyle: TextStyle(fontSize: 25, color: Colors.teal),
                      tabs: [
                        Text(
                          "Encrypt",
                        ),
                        Text("Decrypt"),
                      ],
                      indicatorColor: Colors.teal,
                    ),
                  )
                ]),
          ),
        ));
  }
}
