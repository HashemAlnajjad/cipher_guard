import 'dart:typed_data';

import 'exceptions/invalid_padding_exception.dart';

class Padding {

  /// Applies PKCS7 padding to data.
  /// @param plaintextBytes data to pad
  /// @return padded data
  static Uint8List applyPadding(Uint8List plaintextBytes) {
    int blockSize = 16;
    int paddingLength = blockSize - (plaintextBytes.length % blockSize);
    Uint8List padding = Uint8List(paddingLength);
    for (int i = 0; i < paddingLength; i++) {
      padding[i] = paddingLength;
    }
    return Uint8List.fromList(plaintextBytes + padding);
  }

  /// Removes PKCS7 padding.
  /// @param paddedText padded text
  /// @return text with removed padding
  static Uint8List removePadding(Uint8List paddedText) {
    int paddingLength = paddedText[paddedText.length - 1];
    if (paddingLength < 1 || paddingLength > 16) {
      throw InvalidPaddingException("Invalid padding length.");
    }
    for (int i = 0; i < paddingLength; i++) {
      if (paddedText[paddedText.length - 1 - i] != paddingLength) {
        throw InvalidPaddingException("Invalid padding byte.");
      }
    }
    return Uint8List.sublistView(paddedText, 0, paddedText.length - paddingLength);
  }
}
