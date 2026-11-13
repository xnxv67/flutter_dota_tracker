import 'package:equatable/equatable.dart';

import '../../../core/error/app_exception.dart';
import '../../../domain/entities/player_summary.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.players = const [],
    this.query = '',
    this.error,
  });

  final SearchStatus status;
  final List<PlayerSummary> players;
  final String query;
  final AppErrorType? error;

  bool get isLoading => status == SearchStatus.loading;

  bool get hasQuery => query.trim().isNotEmpty;

  SearchState copyWith({
    SearchStatus? status,
    List<PlayerSummary>? players,
    String? query,
    AppErrorType? error,
    bool clearError = false,
  }) {
    return SearchState(
      status: status ?? this.status,
      players: players ?? this.players,
      query: query ?? this.query,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [status, players, query, error];
}
