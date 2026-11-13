import 'package:equatable/equatable.dart';

import 'hero.dart';

class RecentMatch extends Equatable {
  const RecentMatch({
    required this.matchId,
    required this.hero,
    required this.win,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.startTime,
    required this.duration,
  });

  final int matchId;
  final Hero hero;
  final bool win;
  final int kills;
  final int deaths;
  final int assists;
  final int startTime;
  final int duration;

  @override
  List<Object?> get props => [
    matchId,
    hero,
    win,
    kills,
    deaths,
    assists,
    startTime,
    duration,
  ];
}
