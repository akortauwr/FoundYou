import 'package:dio/dio.dart';
import 'app_exception.dart';

AppException mapDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutException();
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      switch (statusCode) {
        case 401:
          return const UnauthorizedException();
        case 404:
          return const NotFoundException();
        case 500:
          return const ServerException();
        default:
          return const UnknownException();
      }
    case DioExceptionType.cancel:
      return const UnknownException('Żądanie zostało anulowane');
    case DioExceptionType.connectionError:
      return const NetworkException();
    default:
      return const UnknownException();
  }
}
