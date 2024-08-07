class WrongNumberOfBitsException implements Exception {
  final String message;

  WrongNumberOfBitsException(this.message) {
    print('Error: $message');
  }
}
