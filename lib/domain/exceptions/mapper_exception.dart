

class MapperException<from,to> implements Exception{

  String message;

  MapperException(this.message);
  @override
  String toString() {
    return "error mapping from :$from to $to cause :$message";
  }
}