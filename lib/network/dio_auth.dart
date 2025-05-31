import 'package:dio/dio.dart';

final Dio authDio = Dio(BaseOptions(

  baseUrl: 'http://10.0.2.2:8000/',
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 15),
  headers: {
    'Content-Type': 'application/json',
  },
));