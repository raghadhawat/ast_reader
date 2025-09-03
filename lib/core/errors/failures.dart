import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timedout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timedout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timedout with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate, Please try later');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again!');
      }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422 ||
        statusCode == 404) {
      return ServerFailure(response["message"]);
    }
    // else if (statusCode == 404) {
    //   return ServerFailure('Your request not found, Please try later');
    // }
    else if (statusCode == 500) {
      return ServerFailure('Internal Server error ,Please try later');
    } else {
      return ServerFailure('Opps There was an Error,Please try later');
    }
  }
}
