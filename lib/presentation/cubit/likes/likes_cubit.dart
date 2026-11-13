import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/hero.dart';
import '../../../domain/entities/liked_item.dart';
import '../../../domain/entities/player_summary.dart';
import '../../../domain/repositories/likes_repository.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit(this._repository) : super(const LikesState());

  final LikesRepository _repository;

  Future<void> load() async {
    final items = await _repository.load();
    emit(LikesState(items: items));
  }

  Future<void> toggleHero(Hero hero) async {
    await _toggle(
      LikedItem(
        id: hero.id,
        type: LikedType.hero,
        name: hero.localizedName,
        imageUrl: hero.imageUrl,
        subtitle: hero.roles.take(3).join(' · '),
      ),
    );
  }

  Future<void> togglePlayer(PlayerSummary player) async {
    await _toggle(
      LikedItem(
        id: player.accountId,
        type: LikedType.player,
        name: player.name,
        imageUrl: player.avatarUrl,
        subtitle: 'ID ${player.accountId}',
      ),
    );
  }

  Future<void> remove(LikedItem item) async {
    final next = state.items
        .where(
          (current) => !(current.id == item.id && current.type == item.type),
        )
        .toList();
    emit(LikesState(items: next));
    await _repository.save(next);
  }

  Future<void> _toggle(LikedItem item) async {
    final exists = state.isLiked(item.type, item.id);
    final next = [...state.items];
    if (exists) {
      next.removeWhere(
        (current) => current.id == item.id && current.type == item.type,
      );
    } else {
      next.insert(0, item);
    }
    emit(LikesState(items: next));
    await _repository.save(next);
  }
}
