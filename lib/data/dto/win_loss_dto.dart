class WinLossDto {
  const WinLossDto({required this.wins, required this.losses});

  final int wins;
  final int losses;

  factory WinLossDto.fromJson(Map<String, dynamic> json) {
    return WinLossDto(
      wins: (json['win'] as num?)?.toInt() ?? 0,
      losses: (json['lose'] as num?)?.toInt() ?? 0,
    );
  }
}
