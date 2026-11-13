import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested(this.accountId);

  final int accountId;

  @override
  List<Object?> get props => [accountId];
}

class ProfileRefreshRequested extends ProfileEvent {
  const ProfileRefreshRequested();
}
