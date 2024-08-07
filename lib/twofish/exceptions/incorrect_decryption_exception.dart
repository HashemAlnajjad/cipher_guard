class IncorrectDecryptionException implements Exception {
  final String message;

  IncorrectDecryptionException(this.message) {
    print('Decrypted data is not valid.');
  }

  @override
  String toString() => 'IncorrectDecryptionException: $message';
}
