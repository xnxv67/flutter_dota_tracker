import '../../core/error/error_mapper.dart';
import '../../domain/entities/hero.dart';
import '../../domain/entities/hero_stat.dart';
import '../../domain/repositories/hero_repository.dart';
import '../datasources/open_dota_api.dart';

class HeroRepositoryImpl implements HeroRepository {
  HeroRepositoryImpl(this._api);

  final OpenDotaApi _api;

  @override
  Future<List<Hero>> getHeroes() {
    return mapNetworkErrors(() async {
      final heroes = await _api.getHeroes();
      return heroes.map((dto) => dto.toEntity()).toList();
    });
  }

  @override
  Future<List<HeroStat>> getHeroStats() {
    return mapNetworkErrors(() async {
      final stats = await _api.getHeroStats();
      return stats.map((dto) => dto.toEntity()).toList();
    });
  }
}
