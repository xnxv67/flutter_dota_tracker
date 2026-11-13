import '../../domain/entities/player_summary.dart';

class SearchPlayerDto {
  const SearchPlayerDto({
    required this.accountId,
    required this.name,
    required this.avatarUrl,
    required this.lastMatchTime,
  });

  final int accountId;
  final String name;
  final String avatarUrl;
  final DateTime? lastMatchTime;

  factory SearchPlayerDto.fromJson(Map<String, dynamic> json) {
    return SearchPlayerDto(
      accountId: (json['account_id'] as num?)?.toInt() ?? 0,
      name: json['personaname']?.toString() ?? '',
      avatarUrl: json['avatarfull']?.toString() ?? '',
      lastMatchTime: DateTime.tryParse(
        json['last_match_time']?.toString() ?? '',
      ),
    );
  }

  PlayerSummary toEntity() {
    return PlayerSummary(
      accountId: accountId,
      name: name.isEmpty ? 'Player $accountId' : name,
      avatarUrl: avatarUrl,
      lastMatchTime: lastMatchTime,
    );
  }
}
