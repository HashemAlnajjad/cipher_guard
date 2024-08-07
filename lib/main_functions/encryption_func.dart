import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as fernet;
import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cipher_guard/controllers/app_service.dart';
import 'package:cipher_guard/salt/salt.dart';
import 'package:cipher_guard/twofish/key_wrapper.dart';
import 'package:cipher_guard/twofish/twofish.dart';

abstract class IEncryption {
  Future<File> saveFile(String file);

  Future<void> encrypt(AppService app, BuildContext context, String path);

  Future<void> decrypt(AppService app, BuildContext context, String path);
}

class EncryptionAES extends IEncryption {
  late String encFilepath;
  late String filename;
  late String decFilepath;

  @override
  Future<void> decrypt(
      AppService app, BuildContext context, String path) async {
    DateTime startTime = DateTime.now();
    // Creates an instance of AesCrypt class.
    AesCrypt crypt = AesCrypt();
    crypt.aesSetMode(AesMode.cbc);
    crypt.setOverwriteMode(AesCryptOwMode.rename);
    crypt.setPassword(app.currentUser!.password);

    try {
      decFilepath = crypt.decryptFileSync(path);
      DateTime endTime = DateTime.now();
      Duration executionTime = endTime.difference(startTime);
      saveDecryption(
          app, decFilepath, "${executionTime.inMilliseconds}", endTime);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Decryption Success in ${executionTime.inMilliseconds} ms',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
      await saveFile(decFilepath);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File Saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            ' Decryption completed unsuccessfully! wrong password that is not your file',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  @override
  Future<void> encrypt(
      AppService app, BuildContext context, String path) async {
    DateTime startTime = DateTime.now();
    FocusScope.of(context).unfocus();
    // Creates an instance of AesCrypt class.
    AesCrypt crypt = AesCrypt();

    // Sets encryption password.
    // Optionally you can specify the password when creating an instance
    // of AesCrypt class like:
    crypt.aesSetMode(AesMode.cbc);
    crypt.setPassword(app.currentUser!.password);

    // Sets overwrite mode.
    // It's optional. By default the mode is 'AesCryptOwMode.warn'.
    crypt.setOverwriteMode(AesCryptOwMode.rename);

    try {
      // Encrypts  file and save encrypted file to a file with
      // '.aes' extension added. In this case it will be '$_path.aes'.
      // It returns a path to encrypted file.

      encFilepath = crypt.encryptFileSync(path);
      await saveFile(encFilepath);
      DateTime endTime = DateTime.now();
      Duration executionTime = endTime.difference(startTime);
      await saveEncryption(
          app, encFilepath, "${executionTime.inMilliseconds}", endTime);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Encryption Success in ${executionTime.inMilliseconds} ms',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File Saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } on AesCryptException catch (e) {
      // It goes here if overwrite mode set as 'AesCryptFnMode.warn'
      // and encrypted file already exists.
      if (e.type == AesCryptExceptionType.destFileExists) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'The encryption has been completed unsuccessfully.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )));
      }
    }
  }

  @override
  Future<File> saveFile(String file) async {
    Directory? appStorage = await getExternalStorageDirectory();
    var fileName = (file.split('/').last);
    await Directory("${appStorage!.path}/AES").create(recursive: true);
    final newFile = ('${appStorage.path}/AES/$fileName');
    return File(file).copy(newFile);
  }

  Future<void> saveEncryption(
      AppService app, String fileName, String time, DateTime date) async {
    await app.createEncrypt(
        userId: app.currentUser!.id,
        algoName: "AES",
        fileName: fileName,
        time: time,
        date: date);
  }

  Future<void> saveDecryption(
      AppService app, String fileName, String time, DateTime date) async {
    await app.createDecrypt(
        userId: app.currentUser!.id,
        algoName: "AES",
        fileName: fileName,
        time: time,
        date: date);
  }
}

class EncryptionFERNET extends IEncryption {
  late String encFilepath;
  late String filename;
  late String decFilepath;

  fernet.Key generateFernetKey(String text) {
    assert(text.isNotEmpty);
    List<int> bytes = text.codeUnits;
    var salt = Salt().salt;
    return fernet.Key.fromUtf8(String.fromCharCodes(bytes))
        .stretch(32, salt: salt);
  }

  @override
  Future<void> decrypt(
      AppService app, BuildContext context, String path) async {
    DateTime startTime = DateTime.now();

    File file = File(path);
    // read the encrypted file
    var fileContent = file.readAsStringSync();
    var key = generateFernetKey(app.currentUser!.password);

    // generate Fernet key
    final base64Key = base64Url.encode(key.bytes);
    final fernetKey = fernet.Key.fromBase64(base64Key);
    // create the encryptor
    final encryptor = fernet.Encrypter(fernet.Fernet(fernetKey));
    final encryptedBytes = base64.decode(fileContent);

    try {
      // decrypt the file
      final decryptedContent =
          encryptor.decryptBytes(fernet.Encrypted(encryptedBytes));
      // Encrypts  file and save encrypted file to a file with
      // '.fernet' extension added. In this case it will be '$_path.fernet'.
      // It returns a path to encrypted file.
      decFilepath = path.substring(0, path.length - 7);
      final decryptedFile = File(decFilepath);
      // write the decrypted file
      decryptedFile.writeAsBytesSync(decryptedContent);
      await saveFile(decFilepath);
      DateTime endTime = DateTime.now();
      // calculate process time
      Duration executionTime = endTime.difference(startTime);
      saveDecryption(
          app, decFilepath, "${executionTime.inMilliseconds}", endTime);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Encryption Success in ${executionTime.inMilliseconds} ms',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File Saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            ' Decryption completed unsuccessfully! that is not your file',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  @override
  Future<void> encrypt(
      AppService app, BuildContext context, String path) async {
    DateTime startTime = DateTime.now();
    File file = File(path);
    // read the file
    var fileContent = file.readAsBytesSync();
    // generate Fernet key
    var key = generateFernetKey(app.currentUser!.password);
    final base64Key = base64Url.encode(key.bytes);
    final fernetKey = fernet.Key.fromBase64(base64Key);
    // create the encryptor
    final encryptor = fernet.Encrypter(fernet.Fernet(fernetKey));

    // encrypt the file
    final encryptedContent = encryptor.encryptBytes(fileContent);

    try {
      // Encrypts  file and save encrypted file to a file with
      // '.fernet' extension added. In this case it will be '$_path.fernet'.
      // It returns a path to encrypted file.

      File encryptedFile = File('$path.fernet');
      encFilepath = encryptedFile.path;
      encryptedFile.writeAsStringSync(encryptedContent.base64);
      await saveFile(encFilepath);
      DateTime endTime = DateTime.now();
      Duration executionTime = endTime.difference(startTime);
      await saveEncryption(
          app, encFilepath, "${executionTime.inMilliseconds}", endTime);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Encryption Success in ${executionTime.inMilliseconds} ms',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File Saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            "The encryption has been completed unsuccessfully. \n please try again ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  @override
  Future<File> saveFile(String file) async {
    Directory? appStorage = await getExternalStorageDirectory();
    var fileName = (file.split('/').last);
    await Directory("${appStorage!.path}/FERNET").create(recursive: true);
    final newFile = ('${appStorage.path}/FERNET/$fileName');
    return File(file).copy(newFile);
  }

  Future<void> saveEncryption(
      AppService app, String fileName, String time, DateTime date) async {
    await app.createEncrypt(
        userId: app.currentUser!.id,
        algoName: "FERNET",
        fileName: fileName,
        time: time,
        date: date);
  }

  Future<void> saveDecryption(
      AppService app, String fileName, String time, DateTime date) async {
    await app.createDecrypt(
        userId: app.currentUser!.id,
        algoName: "FERNET",
        fileName: fileName,
        time: time,
        date: date);
  }
}

class EncryptionTwoFish extends IEncryption {
  late String encFilepath;
  late String filename;
  late String decFilepath;

  fernet.Key generateFernetKey(String text) {
    assert(text.isNotEmpty);
    List<int> bytes = text.codeUnits;
    var salt = Salt().salt;
    return fernet.Key.fromUtf8(String.fromCharCodes(bytes))
        .stretch(32, salt: salt);
  }

  @override
  Future<void> decrypt(
      AppService app, BuildContext context, String path) async {
    DateTime startTime = DateTime.now();
    File file = File(path);
    // read the encrypted file
    var fileContent = file.readAsBytesSync();
    Uint8List key =
        Uint8List.fromList(KeyWrapper.formatKey(app.currentUser!.password));
    final decryptedContent = Twofish.twofishECBDecrypt(fileContent, key);
    try {
      decFilepath = path.substring(0, path.length - 8);
      final decryptedFile = File(decFilepath);
      // write the decrypted file
      decryptedFile.writeAsBytesSync(decryptedContent);
      await saveFile(decFilepath);
      DateTime endTime = DateTime.now();
      // calculate process time
      Duration executionTime = endTime.difference(startTime);
      saveDecryption(
          app, decFilepath, "${executionTime.inMilliseconds}", endTime);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Encryption Success in ${executionTime.inMilliseconds} ms',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File Saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            ' Decryption completed unsuccessfully! that is not your file',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  @override
  Future<void> encrypt(
      AppService app, BuildContext context, String path) async {
    DateTime startTime = DateTime.now();
    File file = File(path);
    // read the file
    var fileContent = file.readAsBytesSync();
    Uint8List key =
        Uint8List.fromList(KeyWrapper.formatKey(app.currentUser!.password));
    var encrypted = Twofish.twofishECBEncrypt(fileContent, key);
    try {
      File encryptedFile = File('$path.twofish');
      encFilepath = encryptedFile.path;
      encryptedFile.writeAsBytesSync(encrypted);
      await saveFile(encFilepath);
      DateTime endTime = DateTime.now();
      Duration executionTime = endTime.difference(startTime);
      saveEncryption(
          app, encFilepath, "${executionTime.inMilliseconds}", endTime);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff006aff),
          content: Text(
            ' File Encryption Success in ${executionTime.inMilliseconds} ms',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            ' File Saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff006aff),
          content: Text(
            "The encryption has been completed unsuccessfully. \n please try again ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  @override
  Future<File> saveFile(String file) async {
    Directory? appStorage = await getExternalStorageDirectory();
    var fileName = (file.split('/').last);
    await Directory("${appStorage!.path}/TwoFish").create(recursive: true);
    final newFile = ('${appStorage.path}/TwoFish/$fileName');
    return File(file).copy(newFile);
  }

  Future<void> saveEncryption(
      AppService app, String fileName, String time, DateTime date) async {
    await app.createEncrypt(
        userId: app.currentUser!.id,
        algoName: "TwoFish",
        fileName: fileName,
        time: time,
        date: date);
  }

  Future<void> saveDecryption(
      AppService app, String fileName, String time, DateTime date) async {
    await app.createDecrypt(
        userId: app.currentUser!.id,
        algoName: "TwoFish",
        fileName: fileName,
        time: time,
        date: date);
  }
}
