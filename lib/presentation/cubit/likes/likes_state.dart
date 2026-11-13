import 'package:equatable/equatable.dart';

import '../../../domain/entities/liked_item.dart';

class LikesState extends Equatable {
  const LikesState({this.items = const []});

  final List<LikedItem> items;

  bool isLiked(LikedType type, int id) {
    return items.any((item) => item.type == type && item.id == id);
  }

  List<LikedItem> byType(LikedType type) {
    return items.where((item) => item.type == type).toList();
  }

  @override
  List<Object?> get props => [items];
}
