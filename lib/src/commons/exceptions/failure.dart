abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ApiFailure implements Failure {
  final String messages;

  ApiFailure({required this.messages});
  @override
  String get message =>messages;
}
