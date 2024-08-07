import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cipher_guard/controllers/encryption_controller.dart';
import 'package:cipher_guard/main_functions/encryption_func.dart';

class EncryptionPage extends StatelessWidget {
  EncryptionPage({super.key});

  final EncryptionController controller = EncryptionController();

  Widget _buildRadio() {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RadioListTile(
                activeColor: Colors.teal,
                title: Text(
                  "AES",
                  style: TextStyle(
                      color: (controller.currentOption.value ==
                              controller.encOption[0])
                          ? Colors.teal
                          : Colors.white54),
                ),
                value: controller.encOption[0],
                groupValue: controller.currentOption.value,
                onChanged: (val) {
                  controller.currentOption.value = val!;
                  controller.cipher = EncryptionAES();
                }),
            RadioListTile(
                activeColor: Colors.teal,
                title: Text(
                  "FERNET",
                  style: TextStyle(
                      color: (controller.currentOption.value ==
                              controller.encOption[1])
                          ? Colors.teal
                          : Colors.white54),
                ),
                value: controller.encOption[1],
                groupValue: controller.currentOption.value,
                onChanged: (val) {
                  controller.currentOption.value = val!;
                  controller.cipher = EncryptionFERNET();
                }),
            RadioListTile(
                activeColor: Colors.teal,
                title: Text(
                  "TwoFish",
                  style: TextStyle(
                      color: (controller.currentOption.value ==
                              controller.encOption[2])
                          ? Colors.teal
                          : Colors.white54),
                ),
                value: controller.encOption[2],
                groupValue: controller.currentOption.value,
                onChanged: (val) {
                  controller.currentOption.value = val!;
                  controller.cipher = EncryptionTwoFish();
                }),
          ],
        ));
  }

  Widget _buildLogo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Encryption',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 25,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              )),
        ],
      ),
    );
  }

  Widget _buildAddFileButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () async {
              await controller.addFile(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: const StadiumBorder(),
            ),
            child: Text(
              "Add File",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEncryptButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: const StadiumBorder(),
            ),
            onPressed: () async {
              await controller.encrypt(context);
            },
            child: Text(
              "Encrypt",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 10,
                  blurRadius: 100,
                  offset: Offset(20, 20), // changes position of shadow
                ),
              ],
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildRadio(),
                _buildAddFileButton(context),
                _buildEncryptButton(context)
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
           Center(
                child: ListView(
              children: <Widget>[
                _buildLogo(context),
                _buildContainer(context),
               ],
            ))
          ],
        ),
      ),
    );
  }
}
