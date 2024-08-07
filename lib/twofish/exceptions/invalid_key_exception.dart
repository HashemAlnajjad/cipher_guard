
class InvalidKeyException implements Exception {
  final String message;

  InvalidKeyException(this.message) {
    print(message);
  }
}