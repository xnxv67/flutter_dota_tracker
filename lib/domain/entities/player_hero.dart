import 'package:equatable/equatable.dart';

import 'hero.dart';

class PlayerHero extends Equatable {
  const PlayerHero({
    required this.hero,
    required this.games,
    required this.wins,
  });

  final Hero hero;
  final int games;
  final int wins;

  double get winRate => games == 0 ? 0 : wins / games;

  @override
  List<Object?> get props => [hero, games, wins];
}
