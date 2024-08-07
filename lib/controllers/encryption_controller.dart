import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cipher_guard/main_functions/encryption_func.dart';
import 'app_service.dart';

class EncryptionController extends GetxController {
  EncryptionController() {
    app = Get.find<AppService>();
    encOption = ["AES", "FERNET", "TwoFish"];
    currentOption = RxString(encOption[0]);
    cipher = EncryptionAES();
    path = null;
  }

  late final AppService app;
  late IEncryption cipher;
  late String? path;
  late String pat;
  late String encFilepath;
  late String filename;
  late List<String> encOption;
  late RxString currentOption;

  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> requestStoragePermission(BuildContext context) async {
    if (!await Permission.storage.isGranted) {
      final permissionStatus = await Permission.storage.request();
      if (permissionStatus != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xffee122a),
          content: Text("denied"),
        ));
      }
    }
  }

  Future<void> addFile(BuildContext context) async {
    PlatformFile? platformFile;
    final file = await FilePicker.platform.pickFiles();
    if (file != null) {
      platformFile = file.files.first;
      pat = platformFile.name;
      path = platformFile.path;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Selected\n File path:$path',
            textAlign: TextAlign.center,
          )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File not Selected.Abort',
            textAlign: TextAlign.center,
          )));
    }
  }

  Future<void> encrypt(BuildContext context) async {
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Please select file',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } else {
      await cipher.encrypt(app, context, path!);
      path = null;
    }
  }
}
