class GraphQlException implements Exception {
  String msg;

  GraphQlException(this.msg);
}

class LocalException implements Exception {
  LocalException();
}
