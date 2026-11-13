import 'package:equatable/equatable.dart';

import 'player_hero.dart';
import 'recent_match.dart';

class PlayerProfile extends Equatable {
  const PlayerProfile({
    required this.accountId,
    required this.name,
    required this.avatarUrl,
    required this.rankTier,
    required this.leaderboardRank,
    required this.wins,
    required this.losses,
    required this.recentMatches,
    required this.topHeroes,
  });

  final int accountId;
  final String name;
  final String avatarUrl;
  final int rankTier;
  final int? leaderboardRank;
  final int wins;
  final int losses;
  final List<RecentMatch> recentMatches;
  final List<PlayerHero> topHeroes;

  int get totalGames => wins + losses;

  double get winRate => totalGames == 0 ? 0 : wins / totalGames;

  bool get hasAvatar => avatarUrl.isNotEmpty;

  @override
  List<Object?> get props => [
    accountId,
    name,
    avatarUrl,
    rankTier,
    leaderboardRank,
    wins,
    losses,
    recentMatches,
    topHeroes,
  ];
}
