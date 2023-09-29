

class ServerException implements Exception{
  String message;
  int statusCode;
  ServerException(this.statusCode,this.message);

  @override
  String toString() {
    return "Server Exception :$message status code :$statusCode";
  }
}