import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/utils/debounce.dart';
import '../../../domain/repositories/player_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._repository) : super(const SearchState()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(ApiConstants.searchDebounce),
    );
    on<SearchRetried>(_onRetried);
    on<SearchCleared>(_onCleared);
  }

  final PlayerRepository _repository;

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.length < 2) {
      emit(SearchState(query: query));
      return;
    }

    if (query == state.query && state.status == SearchStatus.success) {
      return;
    }

    emit(
      state.copyWith(
        status: SearchStatus.loading,
        query: query,
        clearError: true,
      ),
    );

    await _search(query, emit);
  }

  Future<void> _onRetried(
    SearchRetried event,
    Emitter<SearchState> emit,
  ) async {
    if (state.query.trim().length < 2) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loading, clearError: true));
    await _search(state.query.trim(), emit);
  }

  void _onCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }

  Future<void> _search(String query, Emitter<SearchState> emit) async {
    try {
      final players = await _repository.searchPlayers(query);
      if (state.query != query || state.status != SearchStatus.loading) {
        return;
      }
      emit(
        SearchState(
          status: SearchStatus.success,
          players: players,
          query: query,
        ),
      );
    } on AppException catch (error) {
      if (state.query != query || state.status != SearchStatus.loading) {
        return;
      }
      emit(
        SearchState(
          status: SearchStatus.failure,
          query: query,
          error: error.type,
        ),
      );
    }
  }
}
