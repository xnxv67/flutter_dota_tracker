import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/app_exception.dart';
import '../../../domain/entities/hero_stat.dart';
import '../../../domain/repositories/hero_repository.dart';
import 'meta_event.dart';
import 'meta_state.dart';

class MetaBloc extends Bloc<MetaEvent, MetaState> {
  MetaBloc(this._repository) : super(const MetaState()) {
    on<MetaLoadRequested>(_onLoad);
    on<MetaRefreshRequested>(_onRefresh);
    on<MetaLaneChanged>(_onLaneChanged);
  }

  final HeroRepository _repository;

  Future<void> _onLoad(MetaLoadRequested event, Emitter<MetaState> emit) async {
    emit(state.copyWith(status: MetaStatus.loading, clearError: true));
    await _loadMeta(emit);
  }

  Future<void> _onRefresh(
    MetaRefreshRequested event,
    Emitter<MetaState> emit,
  ) async {
    emit(state.copyWith(status: MetaStatus.loading, clearError: true));
    await _loadMeta(emit);
  }

  void _onLaneChanged(MetaLaneChanged event, Emitter<MetaState> emit) {
    emit(state.copyWith(lane: event.lane));
  }

  Future<void> _loadMeta(Emitter<MetaState> emit) async {
    try {
      final heroes = await _repository.getHeroes();
      final stats = await _repository.getHeroStats();
      final statsById = <int, HeroStat>{
        for (final stat in stats) stat.heroId: stat,
      };

      final items = <MetaHero>[];
      for (final hero in heroes) {
        final stat = statsById[hero.id];
        if (stat != null && stat.picks > 0) {
          items.add(MetaHero(hero: hero, stat: stat));
        }
      }
      items.sort(
        (first, second) => second.stat.winRate.compareTo(first.stat.winRate),
      );

      emit(
        state.copyWith(
          status: MetaStatus.success,
          items: items,
          clearError: true,
        ),
      );
    } on AppException catch (error) {
      emit(state.copyWith(status: MetaStatus.failure, error: error.type));
    }
  }
}
