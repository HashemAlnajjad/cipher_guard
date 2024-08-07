import 'dart:typed_data';

class Salt {
  late Uint8List salt;

  Salt() {
    salt = Uint8List(32);
  }
}
