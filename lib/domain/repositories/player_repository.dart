import '../entities/player_profile.dart';
import '../entities/player_summary.dart';

abstract interface class PlayerRepository {
  Future<List<PlayerSummary>> searchPlayers(String query);

  Future<PlayerProfile> getPlayerProfile(int accountId);
}
