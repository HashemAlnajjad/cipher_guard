
class InvalidHexException implements Exception {
  final String errorMessage;

  InvalidHexException(this.errorMessage);

  @override
  String toString() {
    return 'InvalidHexException: $errorMessage';
  }
}
