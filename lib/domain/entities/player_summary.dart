import 'package:equatable/equatable.dart';

class PlayerSummary extends Equatable {
  const PlayerSummary({
    required this.accountId,
    required this.name,
    required this.avatarUrl,
    this.lastMatchTime,
  });

  final int accountId;
  final String name;
  final String avatarUrl;
  final DateTime? lastMatchTime;

  bool get hasAvatar => avatarUrl.isNotEmpty;

  @override
  List<Object?> get props => [accountId, name, avatarUrl, lastMatchTime];
}
