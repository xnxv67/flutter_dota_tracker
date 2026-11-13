enum AppErrorType { network, notFound, server, unknown }

class AppException implements Exception {
  const AppException(this.type, [this.details]);

  final AppErrorType type;
  final String? details;

  @override
  String toString() => 'AppException($type, $details)';
}
