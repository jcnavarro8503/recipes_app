import 'package:equatable/equatable.dart';
import 'package:recipes_app/core/index.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final Message? message;

  const Failure({this.statusCode, this.message});

  @override
  List<Object?> get props => [statusCode, message];
}

class BadRequestFailure extends Failure {
  BadRequestFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 400,
          message: message ?? ErrorMessage('Bad Request', ''),
        );
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 401,
          message: message ?? ErrorMessage('Unauthorized', ''),
        );
}

class ForbidenFailure extends Failure {
  ForbidenFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 403,
          message: message ?? ErrorMessage('Forbidden', ''),
        );
}

class NotFoundFailure extends Failure {
  NotFoundFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 404,
          message: message ?? ErrorMessage('Not Found', ''),
        );
}

class TimeOutFailure extends Failure {
  TimeOutFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 408,
          message: message ?? ErrorMessage('Request Time-out', ''),
        );
}

class ServerFailure extends Failure {
  ServerFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 500,
          message: message ?? ErrorMessage('Server Error', ''),
        );
}

class UnknownFailure extends Failure {
  UnknownFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 520,
          message: message ?? ErrorMessage('Unknown Error', ''),
        );
}

class CacheFailure extends Failure {
  CacheFailure({int? statusCode, Message? message})
      : super(
          statusCode: statusCode ?? 0,
          message: message ?? InfoMessage('Cache Error', ''),
        );
}
