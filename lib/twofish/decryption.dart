import 'constants.dart';
import 'intermediate_utility_methods.dart';

class Decryption {
  /// Decrypt one block of ciphertext in ECB mode (no IV).
  ///
  /// @param in         Ciphertext.
  /// @param inOffset   Index of in from which to start considering data. Use when decrypting data larger than 1 block
  ///                   to specify, which block is to be decrypted.
  /// @param sessionKey The session key to use for decryption.
  /// @return The plaintext generated from a ciphertext using the session key.
  static List<int> blockDecrypt(List<int> input, int inOffset, List<Object> sessionKey) {
    List<int> sBox = sessionKey[0] as List<int>;
    List<int> sKey = sessionKey[1] as List<int>;

    int x2 = (input[inOffset++] & 0xFF) |
    (input[inOffset++] & 0xFF) << 8 |
    (input[inOffset++] & 0xFF) << 16 |
    (input[inOffset++] & 0xFF) << 24;
    int x3 = (input[inOffset++] & 0xFF) |
    (input[inOffset++] & 0xFF) << 8 |
    (input[inOffset++] & 0xFF) << 16 |
    (input[inOffset++] & 0xFF) << 24;
    int x0 = (input[inOffset++] & 0xFF) |
    (input[inOffset++] & 0xFF) << 8 |
    (input[inOffset++] & 0xFF) << 16 |
    (input[inOffset++] & 0xFF) << 24;
    int x1 = (input[inOffset++] & 0xFF) |
    (input[inOffset++] & 0xFF) << 8 |
    (input[inOffset++] & 0xFF) << 16 |
    (input[inOffset++] & 0xFF) << 24;

    x2 ^= sKey[4];
    x3 ^= sKey[5];
    x0 ^= sKey[6];
    x1 ^= sKey[7];

    int k = Constants.ROUND_SUBKEYS + 2 * Constants.ROUNDS - 1;
    int t0, t1;
    for (int R = 0; R < Constants.ROUNDS; R += 2) {
      t0 = IntermediateUtilityMethods.fe32(sBox, x2, 0);
      t1 = IntermediateUtilityMethods.fe32(sBox, x3, 3);
      x1 ^= t0 + 2 * t1 + sKey[k--];
      x1 = (x1 >>> 1) | (x1 << 31);
      x0 = (x0 << 1) | (x0 >>> 31);
      x0 ^= t0 + t1 + sKey[k--];

      t0 = IntermediateUtilityMethods.fe32(sBox, x0, 0);
      t1 = IntermediateUtilityMethods.fe32(sBox, x1, 3);
      x3 ^= t0 + 2 * t1 + sKey[k--];
      x3 = (x3 >>> 1) | (x3 << 31);
      x2 = (x2 << 1) | (x2 >>> 31);
      x2 ^= t0 + t1 + sKey[k--];
    }
    x0 ^= sKey[0];
    x1 ^= sKey[1];
    x2 ^= sKey[2];
    x3 ^= sKey[3];

    List<int> result = [
      x0 & 0xFF, (x0 >>> 8) & 0xFF, (x0 >>> 16) & 0xFF, (x0 >>> 24) & 0xFF,
      x1 & 0xFF, (x1 >>> 8) & 0xFF, (x1 >>> 16) & 0xFF, (x1 >>> 24) & 0xFF,
      x2 & 0xFF, (x2 >>> 8) & 0xFF, (x2 >>> 16) & 0xFF, (x2 >>> 24) & 0xFF,
      x3 & 0xFF, (x3 >>> 8) & 0xFF, (x3 >>> 16) & 0xFF, (x3 >>> 24) & 0xFF,
    ];

    return result;
  }
}


