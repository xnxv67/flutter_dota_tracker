import '../../domain/entities/hero_stat.dart';

class HeroStatsDto {
  const HeroStatsDto({
    required this.heroId,
    required this.picks,
    required this.wins,
  });

  final int heroId;
  final int picks;
  final int wins;

  factory HeroStatsDto.fromJson(Map<String, dynamic> json) {
    var picks = _sumBrackets(json, 'pick');
    var wins = _sumBrackets(json, 'win');

    if (picks == 0) {
      picks = (json['pub_pick'] as num?)?.toInt() ?? 0;
    }
    if (wins == 0) {
      wins = (json['pub_win'] as num?)?.toInt() ?? 0;
    }

    return HeroStatsDto(
      heroId:
          (json['hero_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      picks: picks,
      wins: wins,
    );
  }

  HeroStat toEntity() {
    return HeroStat(heroId: heroId, picks: picks, wins: wins);
  }

  static int _sumBrackets(Map<String, dynamic> json, String suffix) {
    var total = 0;
    for (var bracket = 1; bracket <= 8; bracket++) {
      final value = json['${bracket}_$suffix'];
      if (value is num) {
        total += value.toInt();
      }
    }
    return total;
  }
}
