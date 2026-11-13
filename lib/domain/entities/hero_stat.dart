import 'package:equatable/equatable.dart';

import 'hero.dart';

class HeroStat extends Equatable {
  const HeroStat({
    required this.heroId,
    required this.picks,
    required this.wins,
  });

  final int heroId;
  final int picks;
  final int wins;

  double get winRate => picks == 0 ? 0 : wins / picks;

  @override
  List<Object?> get props => [heroId, picks, wins];
}

class MetaHero extends Equatable {
  const MetaHero({required this.hero, required this.stat});

  final Hero hero;
  final HeroStat stat;

  @override
  List<Object?> get props => [hero, stat];
}
