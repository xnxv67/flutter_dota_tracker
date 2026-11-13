import 'package:equatable/equatable.dart';

import '../../../domain/entities/hero.dart';

abstract class MetaEvent extends Equatable {
  const MetaEvent();

  @override
  List<Object?> get props => [];
}

class MetaLoadRequested extends MetaEvent {
  const MetaLoadRequested();
}

class MetaRefreshRequested extends MetaEvent {
  const MetaRefreshRequested();
}

class MetaLaneChanged extends MetaEvent {
  const MetaLaneChanged(this.lane);

  final HeroLane lane;

  @override
  List<Object?> get props => [lane];
}
