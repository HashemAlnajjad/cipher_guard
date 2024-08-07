class InputSizeMismatchException extends ArgumentError {
  InputSizeMismatchException(String message) {
    print("Input must be divisible into 128 bit blocks.");
    print(message);
  }
}
