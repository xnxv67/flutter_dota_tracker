class PlayerHeroDto {
  const PlayerHeroDto({
    required this.heroId,
    required this.games,
    required this.wins,
  });

  final int heroId;
  final int games;
  final int wins;

  factory PlayerHeroDto.fromJson(Map<String, dynamic> json) {
    return PlayerHeroDto(
      heroId: (json['hero_id'] as num?)?.toInt() ?? 0,
      games: (json['games'] as num?)?.toInt() ?? 0,
      wins: (json['win'] as num?)?.toInt() ?? 0,
    );
  }
}
