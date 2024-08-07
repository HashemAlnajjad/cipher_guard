import 'dart:convert';
import 'package:cipher_guard/twofish/constants.dart';
import 'package:cipher_guard/twofish/intermediate_utility_methods.dart';
import 'exceptions/invalid_key_exception.dart';

class KeyWrapper {
  /// Expand a user-supplied key material into a session key.
  ///
  /// @param k The 64/128/192/256-bit user-key to use.
  /// @return This cipher's round keys.
  /// @throws InvalidKeyException If the key is invalid.

  static List<int> formatKey(String keyString) {
    if (keyString == null) {
      throw InvalidKeyException("Null key");
    }

    // Convert keyString to bytes using UTF-8 encoding
    List<int> keyBytes = utf8.encode(keyString);

    // Determine the required key length (8, 16, 24, or 32 bytes)
    int requiredLength = 8;
    if (keyBytes.length <= 8) {
      requiredLength = 8;
    } else if (keyBytes.length <= 16) {
      requiredLength = 16;
    } else if (keyBytes.length <= 24) {
      requiredLength = 24;
    } else {
      requiredLength = 32;
    }

    // Create a new list for the formatted key
    List<int> formattedKey = List.filled(requiredLength, 0);

    // Copy bytes from keyBytes to formattedKey
    for (int i = 0; i < requiredLength; i++) {
      if (i < keyBytes.length) {
        formattedKey[i] = keyBytes[i];
      } else {
        // If keyBytes is shorter than requiredLength, pad with zeros
        formattedKey[i] = 0;
      }
    }

    return formattedKey;
  }

  static List<Object> makeKey(List<int> k) {
    if (k == null) {
      throw InvalidKeyException("Null key");
    }
    int keyBytesLength = k.length;
    if (!(keyBytesLength == 8 || keyBytesLength == 16 || keyBytesLength == 24 || keyBytesLength == 32)) {
      throw InvalidKeyException("Incorrect key length. Allowed key lengths: 8, 16, 24, 32 bytes.");
    }

    int k64Cnt = keyBytesLength ~/ 8;
    int subkeyCnt = Constants.ROUND_SUBKEYS + 2 * Constants.ROUNDS;
    List<int> k32e = List.filled(4, 0); // even 32-bit entities
    List<int> k32o = List.filled(4, 0); // odd 32-bit entities
    List<int> sBoxKey = List.filled(4, 0);

    // split user key material into even and odd 32-bit entities and
    // compute S-box keys using (12, 8) Reed-Solomon code over GF(256)
    int i = 0;
    int j = k64Cnt - 1;
    int offset = 0;

    for (; i < 4 && offset < keyBytesLength; i++, j--) {
      k32e[i] = (k[offset++] & 0xFF) |
      (k[offset++] & 0xFF) << 8 |
      (k[offset++] & 0xFF) << 16 |
      (k[offset++] & 0xFF) << 24;

      k32o[i] = (k[offset++] & 0xFF) |
      (k[offset++] & 0xFF) << 8 |
      (k[offset++] & 0xFF) << 16 |
      (k[offset++] & 0xFF) << 24;

      sBoxKey[j] = IntermediateUtilityMethods.reedSolomonEncode(k32e[i], k32o[i]);
    }


    // compute the round decryption subkeys for PHT. these same subkeys
    // will be used in encryption but will be applied in reverse order.
    int q, A, B;
    List<int> subKeys = List.filled(subkeyCnt, 0);
    for (i = q = 0; i < subkeyCnt ~/ 2; i++, q += Constants.SK_STEP) {
      A = IntermediateUtilityMethods.f32(k64Cnt, q, k32e); // A uses even key entities
      B = IntermediateUtilityMethods.f32(k64Cnt, q + Constants.SK_BUMP, k32o); // B uses odd key entities
      B = B << 8 | B >>> 24;
      A += B;
      subKeys[2 * i] = A; // combine with a PHT
      A += B;
      subKeys[2 * i + 1] = A << Constants.SK_ROTL | A >>> (32 - Constants.SK_ROTL);
    }

    // fully expand the table for speed
    int k0 = sBoxKey[0];
    int k1 = sBoxKey[1];
    int k2 = sBoxKey[2];
    int k3 = sBoxKey[3];
    int b0, b1, b2, b3;
    List<int> sBox = List.filled(4 * 256, 0);
    for (i = 0; i < 256; i++) {
      b0 = b1 = b2 = b3 = i;
      switch (k64Cnt & 3) {
        case 1:
          sBox[2 * i] = Constants.MDS[0][(Constants.P[Constants.P_01][b0] & 0xFF) ^ IntermediateUtilityMethods.lsb16(k0)];
          sBox[2 * i + 1] = Constants.MDS[1][(Constants.P[Constants.P_11][b1] & 0xFF) ^ IntermediateUtilityMethods.mb16(k0)];
          sBox[0x200 + 2 * i] = Constants.MDS[2][(Constants.P[Constants.P_21][b2] & 0xFF) ^ IntermediateUtilityMethods.msb16(k0)];
          sBox[0x200 + 2 * i + 1] = Constants.MDS[3][(Constants.P[Constants.P_31][b3] & 0xFF) ^ IntermediateUtilityMethods.msb8(k0)];
          break;
        case 0: // same as 4
          b0 = (Constants.P[Constants.P_04][b0] & 0xFF) ^ IntermediateUtilityMethods.lsb16(k3);
          b1 = (Constants.P[Constants.P_14][b1] & 0xFF) ^ IntermediateUtilityMethods.mb16(k3);
          b2 = (Constants.P[Constants.P_24][b2] & 0xFF) ^ IntermediateUtilityMethods.msb16(k3);
          b3 = (Constants.P[Constants.P_34][b3] & 0xFF) ^ IntermediateUtilityMethods.msb8(k3);
        case 3:
          b0 = (Constants.P[Constants.P_03][b0] & 0xFF) ^ IntermediateUtilityMethods.lsb16(k2);
          b1 = (Constants.P[Constants.P_13][b1] & 0xFF) ^ IntermediateUtilityMethods.mb16(k2);
          b2 = (Constants.P[Constants.P_23][b2] & 0xFF) ^ IntermediateUtilityMethods.msb16(k2);
          b3 = (Constants.P[Constants.P_33][b3] & 0xFF) ^ IntermediateUtilityMethods.msb8(k2);
        case 2: // 128-bit keys
          sBox[2 * i] = Constants.MDS[0][(Constants.P[Constants.P_01][(Constants.P[Constants.P_02][b0] & 0xFF) ^ IntermediateUtilityMethods.lsb16(k1)] & 0xFF) ^ IntermediateUtilityMethods.lsb16(k0)];
          sBox[2 * i + 1] = Constants.MDS[1][(Constants.P[Constants.P_11][(Constants.P[Constants.P_12][b1] & 0xFF) ^ IntermediateUtilityMethods.mb16(k1)] & 0xFF) ^ IntermediateUtilityMethods.mb16(k0)];
          sBox[0x200 + 2 * i] = Constants.MDS[2][(Constants.P[Constants.P_21][(Constants.P[Constants.P_22][b2] & 0xFF) ^ IntermediateUtilityMethods.msb16(k1)] & 0xFF) ^ IntermediateUtilityMethods.msb16(k0)];
          sBox[0x200 + 2 * i + 1] = Constants.MDS[3][(Constants.P[Constants.P_31][(Constants.P[Constants.P_32][b3] & 0xFF) ^ IntermediateUtilityMethods.msb8(k1)] & 0xFF) ^ IntermediateUtilityMethods.msb8(k0)];
      }
    }

    return [sBox, subKeys];
  }
}


