class PlayerDto {
  const PlayerDto({
    required this.accountId,
    required this.name,
    required this.avatarUrl,
    required this.rankTier,
    required this.leaderboardRank,
  });

  final int accountId;
  final String name;
  final String avatarUrl;
  final int rankTier;
  final int? leaderboardRank;

  factory PlayerDto.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'];
    final profileMap = profile is Map<String, dynamic>
        ? profile
        : const <String, dynamic>{};

    return PlayerDto(
      accountId:
          (json['account_id'] as num?)?.toInt() ??
          (profileMap['account_id'] as num?)?.toInt() ??
          0,
      name: profileMap['personaname']?.toString() ?? '',
      avatarUrl: profileMap['avatarfull']?.toString() ?? '',
      rankTier: (json['rank_tier'] as num?)?.toInt() ?? 0,
      leaderboardRank: (json['leaderboard_rank'] as num?)?.toInt(),
    );
  }
}
