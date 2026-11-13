import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

Dio createDio() {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: const {'Accept': 'application/json'},
    ),
  );
}
