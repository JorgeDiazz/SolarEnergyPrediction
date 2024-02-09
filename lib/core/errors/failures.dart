enum FailureCause { noInternetConnection, notFound, unknown }

abstract class Failure {
  Failure({required this.message, this.statusCode = -1});

  final String message;
  final int statusCode;

  @override
  String toString() {
    return '{ message: $message, statusCode: $statusCode }';
  }
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});
}

class ServicesFailure extends Failure {
  ServicesFailure({required super.message});
}
