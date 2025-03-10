class AppAuthException implements Exception {
  final String message;

  AppAuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
