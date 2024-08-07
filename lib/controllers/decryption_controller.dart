import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cipher_guard/main_functions/encryption_func.dart';
import 'app_service.dart';

class DecryptionController extends GetxController {
  DecryptionController() {
    app = Get.find<AppService>();
    encOption = ["AES", "FERNET", "TwoFish"];
    currentOption = RxString(encOption[0]);
    cipher = EncryptionAES();
    pathPic = null;
  }

  late final AppService app;
  late IEncryption cipher;
  late String? path;
  late String? pathPic;
  late String pat;
  late String decFilepath;
  late String filename;
  late List<String> encOption;
  late RxString currentOption;

  Future<void> addFile(BuildContext context) async {
    Directory? appStorage = await getExternalStorageDirectory();
    var aesDir =
        await Directory("${appStorage!.path}/AES").create(recursive: true);
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(initialDirectory: aesDir.path);

    if (result != null) {
      PlatformFile file = result.files.first;
      pat = file.name;
      pathPic = file.path;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff), content: Text(' File Selected')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(' File not Selected.Abort')));
    }
  }

  Future<void> decrypt(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (pathPic == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Please select file',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } else {
      await cipher.decrypt(app, context, pathPic!);
      pathPic = null;
    }
  }
}
