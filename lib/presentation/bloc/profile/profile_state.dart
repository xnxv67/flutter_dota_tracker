import 'package:equatable/equatable.dart';

import '../../../core/error/app_exception.dart';
import '../../../domain/entities/player_profile.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.accountId = 0,
    this.error,
  });

  final ProfileStatus status;
  final PlayerProfile? profile;
  final int accountId;
  final AppErrorType? error;

  ProfileState copyWith({
    ProfileStatus? status,
    PlayerProfile? profile,
    int? accountId,
    AppErrorType? error,
    bool clearError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      accountId: accountId ?? this.accountId,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [status, profile, accountId, error];
}
