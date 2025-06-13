sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Brak połączenia z internetem']);
}

class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Przekroczono limit czasu']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Nieautoryzowany dostęp']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Nie znaleziono zasobu']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Błąd serwera']);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'Nieznany błąd']);
}
