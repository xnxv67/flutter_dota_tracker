import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/app_exception.dart';
import '../../../domain/repositories/player_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repository) : super(const ProfileState()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileRefreshRequested>(_onRefresh);
  }

  final PlayerRepository _repository;

  Future<void> _onLoad(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      ProfileState(status: ProfileStatus.loading, accountId: event.accountId),
    );
    await _loadProfile(event.accountId, emit);
  }

  Future<void> _onRefresh(
    ProfileRefreshRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.accountId == 0) {
      return;
    }
    emit(state.copyWith(status: ProfileStatus.loading, clearError: true));
    await _loadProfile(state.accountId, emit);
  }

  Future<void> _loadProfile(int accountId, Emitter<ProfileState> emit) async {
    try {
      final profile = await _repository.getPlayerProfile(accountId);
      emit(
        ProfileState(
          status: ProfileStatus.success,
          accountId: accountId,
          profile: profile,
        ),
      );
    } on AppException catch (error) {
      emit(
        ProfileState(
          status: ProfileStatus.failure,
          accountId: accountId,
          error: error.type,
        ),
      );
    }
  }
}
