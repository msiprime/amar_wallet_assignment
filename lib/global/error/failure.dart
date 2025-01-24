class Failure implements Exception {
  final String? message;
  final String? code;

  Failure({
    this.code = "None",
    this.message = "Unexpected Error has Occurred",
  });

  @override
  String toString() {
    return 'ErrorException {message: $message, code: $code}';
  }
}
