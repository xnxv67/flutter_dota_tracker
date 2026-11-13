import '../entities/liked_item.dart';

abstract interface class LikesRepository {
  Future<List<LikedItem>> load();

  Future<void> save(List<LikedItem> items);
}
