import 'package:equatable/equatable.dart';

import '../../../core/error/app_exception.dart';
import '../../../domain/entities/hero.dart';
import '../../../domain/entities/hero_stat.dart';

enum MetaStatus { initial, loading, success, failure }

class MetaState extends Equatable {
  const MetaState({
    this.status = MetaStatus.initial,
    this.items = const [],
    this.lane = HeroLane.carry,
    this.error,
  });

  final MetaStatus status;
  final List<MetaHero> items;
  final HeroLane lane;
  final AppErrorType? error;

  List<MetaHero> get visibleItems {
    return items.where((item) => item.hero.lanes.contains(lane)).toList();
  }

  MetaState copyWith({
    MetaStatus? status,
    List<MetaHero>? items,
    HeroLane? lane,
    AppErrorType? error,
    bool clearError = false,
  }) {
    return MetaState(
      status: status ?? this.status,
      items: items ?? this.items,
      lane: lane ?? this.lane,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [status, items, lane, error];
}
