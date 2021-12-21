class HttpErrorHandle implements Exception {
  final String message;

  HttpErrorHandle(this.message);
  @override
  String toString() {
    return message;
    // TODO: implement toString
    // return super.toString();
  }
}
