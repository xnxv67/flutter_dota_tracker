class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://api.opendota.com/api';
  static const String steamId64Base = '76561197960265728';
  static const String cdnBase = 'https://cdn.cloudflare.steamstatic.com';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration searchDebounce = Duration(milliseconds: 500);
}
