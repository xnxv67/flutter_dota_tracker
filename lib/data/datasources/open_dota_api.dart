import 'package:dio/dio.dart';

import '../dto/hero_dto.dart';
import '../dto/hero_stats_dto.dart';
import '../dto/player_dto.dart';
import '../dto/player_hero_dto.dart';
import '../dto/recent_match_dto.dart';
import '../dto/search_player_dto.dart';
import '../dto/win_loss_dto.dart';

class OpenDotaApi {
  OpenDotaApi(this._dio);

  final Dio _dio;

  Future<List<SearchPlayerDto>> searchPlayers(String query) async {
    final response = await _dio.get<List<dynamic>>(
      '/search',
      queryParameters: {'q': query},
    );
    final data = response.data ?? const <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .map(SearchPlayerDto.fromJson)
        .toList();
  }

  Future<PlayerDto?> getPlayer(int accountId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/players/$accountId',
      );
      final data = response.data;
      if (data == null) {
        return null;
      }
      return PlayerDto.fromJson(data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  Future<WinLossDto> getWinLoss(int accountId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/players/$accountId/wl',
    );
    return WinLossDto.fromJson(response.data ?? const {});
  }

  Future<List<RecentMatchDto>> getRecentMatches(int accountId) async {
    final response = await _dio.get<List<dynamic>>(
      '/players/$accountId/recentMatches',
    );
    final data = response.data ?? const <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .map(RecentMatchDto.fromJson)
        .toList();
  }

  Future<List<PlayerHeroDto>> getPlayerHeroes(int accountId) async {
    final response = await _dio.get<List<dynamic>>(
      '/players/$accountId/heroes',
    );
    final data = response.data ?? const <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .map(PlayerHeroDto.fromJson)
        .toList();
  }

  Future<List<HeroDto>> getHeroes() async {
    final response = await _dio.get<List<dynamic>>('/heroes');
    final data = response.data ?? const <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .map(HeroDto.fromJson)
        .toList();
  }

  Future<List<HeroStatsDto>> getHeroStats() async {
    final response = await _dio.get<List<dynamic>>('/heroStats');
    final data = response.data ?? const <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .map(HeroStatsDto.fromJson)
        .toList();
  }
}
