import '../../core/constants/api_constants.dart';
import '../../core/error/app_exception.dart';
import '../../core/error/error_mapper.dart';
import '../../domain/entities/player_hero.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/entities/player_summary.dart';
import '../../domain/entities/recent_match.dart';
import '../../domain/repositories/player_repository.dart';
import '../datasources/open_dota_api.dart';
import '../dto/hero_dto.dart';
import '../dto/player_hero_dto.dart';
import '../dto/recent_match_dto.dart';
import '../dto/win_loss_dto.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  PlayerRepositoryImpl(this._api);

  final OpenDotaApi _api;

  @override
  Future<List<PlayerSummary>> searchPlayers(String query) {
    return mapNetworkErrors(() async {
      final trimmed = query.trim();
      if (trimmed.isEmpty) {
        return <PlayerSummary>[];
      }

      final numeric = int.tryParse(trimmed);
      if (numeric != null) {
        final steamIdBase = int.parse(ApiConstants.steamId64Base);
        final accountId = numeric > steamIdBase
            ? numeric - steamIdBase
            : numeric;
        if (accountId <= 0) {
          return <PlayerSummary>[];
        }

        final player = await _api.getPlayer(accountId);
        if (player == null) {
          throw const AppException(AppErrorType.notFound);
        }

        return [
          PlayerSummary(
            accountId: accountId,
            name: player.name.isEmpty ? 'Player $accountId' : player.name,
            avatarUrl: player.avatarUrl,
          ),
        ];
      }

      final results = await _api.searchPlayers(trimmed);
      return results.map((dto) => dto.toEntity()).toList();
    });
  }

  @override
  Future<PlayerProfile> getPlayerProfile(int accountId) {
    return mapNetworkErrors(() async {
      final player = await _api.getPlayer(accountId);
      if (player == null) {
        throw const AppException(AppErrorType.notFound);
      }

      final winLoss = await _winLossOrEmpty(accountId);
      final matches = await _matchesOrEmpty(accountId);
      final playerHeroes = await _heroesOrEmpty(accountId);
      final catalog = await _api.getHeroes();
      final heroesById = <int, HeroDto>{
        for (final hero in catalog) hero.id: hero,
      };

      final topHeroes = <PlayerHero>[];
      final sortedHeroes = [...playerHeroes]
        ..sort((first, second) => second.games.compareTo(first.games));
      for (final item in sortedHeroes.take(5)) {
        final hero = heroesById[item.heroId];
        if (hero != null) {
          topHeroes.add(
            PlayerHero(
              hero: hero.toEntity(),
              games: item.games,
              wins: item.wins,
            ),
          );
        }
      }

      final recent = <RecentMatch>[];
      for (final match in matches) {
        final hero = heroesById[match.heroId];
        if (hero != null) {
          recent.add(
            RecentMatch(
              matchId: match.matchId,
              hero: hero.toEntity(),
              win: match.win,
              kills: match.kills,
              deaths: match.deaths,
              assists: match.assists,
              startTime: match.startTime,
              duration: match.duration,
            ),
          );
        }
      }

      return PlayerProfile(
        accountId: accountId,
        name: player.name.isEmpty ? 'Player $accountId' : player.name,
        avatarUrl: player.avatarUrl,
        rankTier: player.rankTier,
        leaderboardRank: player.leaderboardRank,
        wins: winLoss.wins,
        losses: winLoss.losses,
        recentMatches: recent,
        topHeroes: topHeroes,
      );
    });
  }

  Future<WinLossDto> _winLossOrEmpty(int accountId) async {
    try {
      return await _api.getWinLoss(accountId);
    } catch (_) {
      return const WinLossDto(wins: 0, losses: 0);
    }
  }

  Future<List<RecentMatchDto>> _matchesOrEmpty(int accountId) async {
    try {
      return await _api.getRecentMatches(accountId);
    } catch (_) {
      return const [];
    }
  }

  Future<List<PlayerHeroDto>> _heroesOrEmpty(int accountId) async {
    try {
      return await _api.getPlayerHeroes(accountId);
    } catch (_) {
      return const [];
    }
  }
}
