import 'incorrect_decryption_exception.dart';

class InvalidPaddingException extends IncorrectDecryptionException {
  InvalidPaddingException(String message) : super(message) {
    print('Supplied data is padded incorrectly, therefore removal od padding is impossible.');
    print(message);
  }
}