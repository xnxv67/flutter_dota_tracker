import '../entities/hero.dart';
import '../entities/hero_stat.dart';

abstract interface class HeroRepository {
  Future<List<Hero>> getHeroes();

  Future<List<HeroStat>> getHeroStats();
}
