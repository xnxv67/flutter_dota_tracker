class RecentMatchDto {
  const RecentMatchDto({
    required this.matchId,
    required this.heroId,
    required this.win,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.startTime,
    required this.duration,
  });

  final int matchId;
  final int heroId;
  final bool win;
  final int kills;
  final int deaths;
  final int assists;
  final int startTime;
  final int duration;

  factory RecentMatchDto.fromJson(Map<String, dynamic> json) {
    final playerSlot = (json['player_slot'] as num?)?.toInt() ?? 0;
    final radiantWin = json['radiant_win'] == true;
    final playerIsRadiant = playerSlot < 128;

    return RecentMatchDto(
      matchId: (json['match_id'] as num?)?.toInt() ?? 0,
      heroId: (json['hero_id'] as num?)?.toInt() ?? 0,
      win: playerIsRadiant == radiantWin,
      kills: (json['kills'] as num?)?.toInt() ?? 0,
      deaths: (json['deaths'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      startTime: (json['start_time'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    );
  }
}
