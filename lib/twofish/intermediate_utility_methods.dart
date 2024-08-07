import'dart:typed_data';
import 'constants.dart';


class IntermediateUtilityMethods {
  static int lsb16(int x) {
    return x & 0xFF;
  }

  static int mb16(int x) {
    return (x >> 8) & 0xFF;
  }

  static int msb16(int x) {
    return (x >> 16) & 0xFF;
  }

  static int msb8(int x) {
    return (x >> 24) & 0xFF;
  }

  static int f32(int k64Cnt, int x, List<int> k32) {
    int b0 = lsb16(x);
    int b1 = mb16(x);
    int b2 = msb16(x);
    int b3 = msb8(x);
    int k0 = k32[0];
    int k1 = k32[1];
    int k2 = k32[2];
    int k3 = k32[3];

    int result = 0;
    switch (k64Cnt & 3) {
      case 1:
        result =
        Constants.MDS[0][(Constants.P[Constants.P_01][b0] & 0xFF) ^ lsb16(k0)] ^
        Constants.MDS[1][(Constants.P[Constants.P_11][b1] & 0xFF) ^ mb16(k0)] ^
        Constants.MDS[2][(Constants.P[Constants.P_21][b2] & 0xFF) ^ msb16(k0)] ^
        Constants.MDS[3][(Constants.P[Constants.P_31][b3] & 0xFF) ^ msb8(k0)];
        break;
      case 0: // same as 4
        b0 = (Constants.P[Constants.P_04][b0] & 0xFF) ^ lsb16(k3);
        b1 = (Constants.P[Constants.P_14][b1] & 0xFF) ^ mb16(k3);
        b2 = (Constants.P[Constants.P_24][b2] & 0xFF) ^ msb16(k3);
        b3 = (Constants.P[Constants.P_34][b3] & 0xFF) ^ msb8(k3);
      case 3:
        b0 = (Constants.P[Constants.P_03][b0] & 0xFF) ^ lsb16(k2);
        b1 = (Constants.P[Constants.P_13][b1] & 0xFF) ^ mb16(k2);
        b2 = (Constants.P[Constants.P_23][b2] & 0xFF) ^ msb16(k2);
        b3 = (Constants.P[Constants.P_33][b3] & 0xFF) ^ msb8(k2);
      case 2: // 128-bit keys (optimize for this case)
        result =
        Constants.MDS[0][(Constants.P[Constants.P_01][(Constants.P[Constants.P_02][b0] & 0xFF) ^ lsb16(k1)] & 0xFF) ^ lsb16(k0)] ^
        Constants.MDS[1][(Constants.P[Constants.P_11][(Constants.P[Constants.P_12][b1] & 0xFF) ^ mb16(k1)] & 0xFF) ^ mb16(k0)] ^
        Constants.MDS[2][(Constants.P[Constants.P_21][(Constants.P[Constants.P_22][b2] & 0xFF) ^ msb16(k1)] & 0xFF) ^ msb16(k0)] ^
        Constants.MDS[3][(Constants.P[Constants.P_31][(Constants.P[Constants.P_32][b3] & 0xFF) ^ msb8(k1)] & 0xFF) ^ msb8(k0)];
        break;
    }
    return result;
  }

  static int reedSolomonEncode(int k0, int k1) {
    int r = k1;
    for (int i = 0; i < 4; i++) {
      // shift 1 byte at a time
      r = reedSolomonRemainder(r);
    }
    r ^= k0;
    for (int i = 0; i < 4; i++) {
      r = reedSolomonRemainder(r);
    }
    return r;
  }

  static int reedSolomonRemainder(int x) {
    int b = (x >> 24) & 0xFF;
    int g2 = ((b << 1) ^ ((b & 0x80) != 0 ? Constants.RS_GF_FDBK : 0)) & 0xFF;
    int g3 = (b >> 1) ^ ((b & 0x01) != 0 ? (Constants.RS_GF_FDBK >> 1) : 0) ^ g2;
    int result = (x << 8) ^ (g3 << 24) ^ (g2 << 16) ^ (g3 << 8) ^ b;
    return result;
  }

  static int whichBits(int x, int n) {
    int result = 0;
    switch (n % 4) {
      case 0:
        result = lsb16(x);
        break;
      case 1:
        result = mb16(x);
        break;
      case 2:
        result = msb16(x);
        break;
      case 3:
        result = msb8(x);
        break;
    }
    return result;
  }

  static int fe32(List<int> sBox, int x, int r) {
    return sBox[2 * whichBits(x, r)] ^
    sBox[2 * whichBits(x, r + 1) + 1] ^
    sBox[0x200 + 2 * whichBits(x, r + 2)] ^
    sBox[0x200 + 2 * whichBits(x, r + 3) + 1];
  }

  static Uint8List decodeHexString(String hexString) {
    if (hexString.length % 2 == 1) {
      throw Exception('Bit length not a multiple of 8. String: $hexString');
    }

    final bytes = Uint8List((hexString.length / 2).floor());
    for (int i = 0; i < hexString.length; i += 2) {
      bytes[i ~/ 2] = hexToByte(hexString.substring(i, i + 2));
    }
    return bytes;
  }

  static Uint8List encodeHexString(Uint8List bytes) {
    final hexString = StringBuffer();
    for (final b in bytes) {
      hexString.write(String.fromCharCodes([b]));
    }
    return Uint8List.fromList(hexString.toString().codeUnits);
  }

  static int hexToByte(String hexString) {
    final firstDigit = toDigit(hexString.codeUnitAt(0));
    final secondDigit = toDigit(hexString.codeUnitAt(1));
    return (firstDigit << 4) + secondDigit;
  }

  static int toDigit(int hexChar) {
    final digit = int.tryParse(String.fromCharCode(hexChar), radix: 16);
    if (digit == null) {
      throw Exception('Invalid Hexadecimal Character: ${String.fromCharCode(hexChar)}');
    }
    return digit;
  }

  static Uint8List concatenateArrays(Uint8List array1, Uint8List array2) {
    final result = Uint8List(array1.length + array2.length);
    result.setRange(0, array1.length, array1);
    result.setRange(array1.length, array1.length + array2.length, array2);
    return result;
  }

  static Uint8List stringToByteArray(String string) {
    return Uint8List.fromList(string.codeUnits);
  }

  static String byteArrayToHexString(Uint8List bytes) {
    final hexString = StringBuffer();
    for (final b in bytes) {
      hexString.write(b.toRadixString(16).padLeft(2, '0'));
    }
    return hexString.toString();
  }
}

