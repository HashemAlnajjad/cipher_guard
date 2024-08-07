import 'dart:typed_data';
import 'package:cipher_guard/twofish/decryption.dart';
import 'package:cipher_guard/twofish/padding.dart';
import 'package:cipher_guard/twofish/encryption.dart';
import 'package:cipher_guard/twofish/key_wrapper.dart';
import 'exceptions/input_size_mismatch_exception.dart';
import 'intermediate_utility_methods.dart';

class Twofish {
  /// Method used to encrypt byte arrays of data with a key, also given as a byte array. Plaintext bit-length must be a
  /// multiple of 8. Key must be 64/128/192/256 bits in length. WARNING! Encrypted data is padded! See twofish.Padding
  /// class for more info.
  ///
  /// @param plaintext plaintext to encrypt
  /// @param keyBytes  encryption key
  /// @return ciphertext
  /// @throws InvalidKeyException
  static Uint8List twofishECBEncrypt(Uint8List plaintext, Uint8List keyBytes) {
    final plaintextBytes = Padding.applyPadding(plaintext);
    final ciphertext = <int>[];

    final key = KeyWrapper.makeKey(keyBytes);

    for (var i = 0; i < plaintextBytes.length; i += 16) {
      final encryptedBlock = Encryption.blockEncrypt(plaintextBytes, i, key);
      ciphertext.addAll(encryptedBlock);
    }
    return Uint8List.fromList(ciphertext);
  }

  /// Method used to encrypt byte arrays of data with a key, also given as a byte array. Plaintext bit-length must be a
  /// multiple of 8. Key must be 64/128/192/256 bits in length. WARNING! The supplied data won't be padded. Supplied
  /// data byte-length must be a multiple of 16 in order to divide data into Twofish blocks.
  ///
  /// @param plaintext plaintext to encrypt
  /// @param keyBytes  encryption key
  /// @return ciphertext
  /// @throws InvalidKeyException thrown when supplied key does not conform to the Twofish key requirements
  static Uint8List twofishECBEncryptNoPadding(
      Uint8List plaintext, Uint8List keyBytes) {
    if (plaintext.length % 16 != 0) {
      throw InputSizeMismatchException('Plaintext size = ${plaintext.length}');
    }

    final ciphertext = <int>[];

    final key = KeyWrapper.makeKey(keyBytes);

    for (var i = 0; i < plaintext.length; i += 16) {
      final encryptedBlock = Encryption.blockEncrypt(plaintext, i, key);
      ciphertext.addAll(encryptedBlock);
    }
    return Uint8List.fromList(ciphertext);
  }

  /// Method used to decrypt byte arrays of data with a key, also given as a byte array. Method decrypts padded data
  /// and as such it won't decrypt data encrypted without padding. For additional info about the padding scheme refer
  /// to twofish.Padding class. Plaintext bit-length must be a multiple of 8. Key must be 64/128/192/256 bits in
  /// length.
  ///
  /// @param ciphertextBytes ciphertext to decrypt
  /// @param keyBytes        decryption key
  /// @return plaintext
  /// @throws InvalidKeyException     thrown when supplied key does not conform to the Twofish key requirements
  /// @throws InvalidPaddingException thrown when supplied plaintext was not padded correctly
  static Uint8List twofishECBDecrypt(
      Uint8List ciphertextBytes, Uint8List keyBytes) {
    if (ciphertextBytes.length % 16 != 0) {
      throw InputSizeMismatchException(
          'Plaintext size = ${ciphertextBytes.length}');
    }

    final plaintextBytes = <int>[];

    final key = KeyWrapper.makeKey(keyBytes);

    for (var i = 0; i < ciphertextBytes.length; i += 16) {
      final decryptedBlock = Decryption.blockDecrypt(ciphertextBytes, i, key);
      plaintextBytes.addAll(decryptedBlock);
    }
    return Padding.removePadding(Uint8List.fromList(plaintextBytes));
  }

  static Uint8List twofishECBEncryptBytesNoPadding(
      Uint8List ciphertextBytes, String key) {
    return twofishECBEncryptNoPadding(
        ciphertextBytes, IntermediateUtilityMethods.decodeHexString(key));
  }

  static Uint8List twofishECBEncryptStringNoPadding(
      String ciphertext, Uint8List keyBytes) {
    return twofishECBEncryptNoPadding(
        IntermediateUtilityMethods.decodeHexString(ciphertext), keyBytes);
  }

  static Uint8List twofishECBEncryptStringStringKeyNoPadding(
      String ciphertext, String key) {
    return twofishECBEncryptNoPadding(
        IntermediateUtilityMethods.decodeHexString(ciphertext),
        IntermediateUtilityMethods.decodeHexString(key));
  }

  /// Method used to decrypt byte arrays of data with a key, also given as a byte array. Supplied ciphertext's
  /// byte-length must be a multiple of 16 so that it can be divided into Twofish blocks. Key must be 64/128/192/256
  /// bits in length.
  ///
  /// @param ciphertextBytes ciphertext to decrypt
  /// @param keyBytes        decryption key
  /// @return plaintext
  /// @throws InvalidKeyException     thrown when supplied key does not conform to the Twofish key requirements
  /// @throws InvalidPaddingException thrown when supplied plaintext was not padded correctly
  static Uint8List twofishECBDecryptNoPadding(
      Uint8List ciphertextBytes, Uint8List keyBytes) {
    final plaintextBytes = <int>[];

    final key = KeyWrapper.makeKey(keyBytes);

    for (var i = 0; i < ciphertextBytes.length; i += 16) {
      final decryptedBlock = Decryption.blockDecrypt(ciphertextBytes, i, key);
      plaintextBytes.addAll(decryptedBlock);
    }
    return Uint8List.fromList(plaintextBytes);
  }

  static Uint8List twofishECBDecryptBytesNoPadding(
      Uint8List ciphertextBytes, String key) {
    return twofishECBDecryptNoPadding(
        ciphertextBytes, IntermediateUtilityMethods.decodeHexString(key));
  }

  static Uint8List twofishECBDecryptStringNoPadding(
      String ciphertext, Uint8List keyBytes) {
    return twofishECBDecryptNoPadding(
        IntermediateUtilityMethods.decodeHexString(ciphertext), keyBytes);
  }

  static Uint8List twofishECBDecryptStringStringKeyNoPadding(
      String ciphertext, String key) {
    return twofishECBDecryptNoPadding(
        IntermediateUtilityMethods.decodeHexString(ciphertext),
        IntermediateUtilityMethods.decodeHexString(key));
  }

  static Uint8List twofishECBEncryptString(
      String plaintext, Uint8List keyBytes) {
    return twofishECBEncrypt(
        IntermediateUtilityMethods.decodeHexString(plaintext), keyBytes);
  }

  static Uint8List twofishECBDecryptString(
      String ciphertext, Uint8List keyBytes) {
    return twofishECBDecrypt(
        IntermediateUtilityMethods.decodeHexString(ciphertext), keyBytes);
  }

  static Uint8List twofishECBEncryptStringStringKey(
      String plaintext, String keyString) {
    final keyBytes = IntermediateUtilityMethods.decodeHexString(keyString);
    final plaintextBytes =
        IntermediateUtilityMethods.decodeHexString(plaintext);
    return twofishECBEncrypt(plaintextBytes, keyBytes);
  }

  static Uint8List twofishECBDecryptStringStringKey(
      String ciphertext, String keyString) {
    final keyBytes = IntermediateUtilityMethods.decodeHexString(keyString);
    final ciphertextBytes =
        IntermediateUtilityMethods.decodeHexString(ciphertext);
    return twofishECBDecrypt(ciphertextBytes, keyBytes);
  }

  static Uint8List twofishECBEncryptBytes(
      Uint8List plaintext, String keyString) {
    final keyBytes = IntermediateUtilityMethods.decodeHexString(keyString);
    return twofishECBEncrypt(plaintext, keyBytes);
  }

  static Uint8List twofishECBDecryptBytes(
      Uint8List ciphertext, String keyString) {
    final keyBytes = IntermediateUtilityMethods.decodeHexString(keyString);
    return twofishECBDecrypt(ciphertext, keyBytes);
  }
}
