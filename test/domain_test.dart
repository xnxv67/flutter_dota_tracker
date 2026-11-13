import 'package:flutter_dota_tracker/core/utils/formatters.dart';
import 'package:flutter_dota_tracker/data/dto/hero_dto.dart';
import 'package:flutter_dota_tracker/data/dto/hero_stats_dto.dart';
import 'package:flutter_dota_tracker/domain/entities/hero.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Hero lanes', () {
    test('carry hero gets carry lane', () {
      const hero = Hero(
        id: 1,
        name: 'npc_dota_hero_antimage',
        localizedName: 'Anti-Mage',
        primaryAttr: 'agi',
        attackType: 'Melee',
        roles: ['Carry', 'Escape', 'Nuker'],
        imageUrl: '',
        iconUrl: '',
      );

      expect(hero.lanes, contains(HeroLane.carry));
    });

    test('support hero gets support lanes', () {
      const hero = Hero(
        id: 2,
        name: 'npc_dota_hero_crystal_maiden',
        localizedName: 'Crystal Maiden',
        primaryAttr: 'int',
        attackType: 'Ranged',
        roles: ['Support', 'Disabler', 'Nuker'],
        imageUrl: '',
        iconUrl: '',
      );

      expect(hero.lanes, containsAll([HeroLane.support, HeroLane.hardSupport]));
    });
  });

  test('formatters work', () {
    expect(formatPercent(0.523), '52.3%');
    expect(formatDuration(125), '2:05');
    expect(formatKda(7, 2, 11), '7 / 2 / 11');
  });

  test('hero dto builds image url from hero name', () {
    final dto = HeroDto.fromJson({
      'id': 1,
      'name': 'npc_dota_hero_antimage',
      'localized_name': 'Anti-Mage',
      'primary_attr': 'agi',
      'attack_type': 'Melee',
      'roles': ['Carry'],
    });

    expect(
      dto.imageUrl,
      'https://cdn.cloudflare.steamstatic.com'
      '/apps/dota2/images/dota_react/heroes/antimage.png',
    );
  });

  test('hero stats dto reads id and bracket picks', () {
    final stat = HeroStatsDto.fromJson({
      'id': 14,
      '1_pick': 10,
      '1_win': 4,
      '2_pick': 5,
      '2_win': 3,
    }).toEntity();

    expect(stat.heroId, 14);
    expect(stat.picks, 15);
    expect(stat.wins, 7);
  });
}
