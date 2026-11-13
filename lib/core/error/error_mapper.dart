import 'package:dio/dio.dart';

import '../error/app_exception.dart';

Future<T> mapNetworkErrors<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on AppException {
    rethrow;
  } on DioException catch (error) {
    if (error.response?.statusCode == 404) {
      throw const AppException(AppErrorType.notFound);
    }
    if (error.response != null) {
      throw const AppException(AppErrorType.server);
    }
    throw const AppException(AppErrorType.network);
  } catch (_) {
    throw const AppException(AppErrorType.unknown);
  }
}
