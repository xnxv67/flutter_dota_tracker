import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/liked_item.dart';
import '../../domain/repositories/likes_repository.dart';

class LikesRepositoryImpl implements LikesRepository {
  LikesRepositoryImpl(this._preferences);

  static const String _storageKey = 'liked_items_v1';

  final SharedPreferences _preferences;

  @override
  Future<List<LikedItem>> load() async {
    final raw = _preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const [];
      }
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(LikedItem.fromJson)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<void> save(List<LikedItem> items) async {
    final data = items.map((item) => item.toJson()).toList();
    await _preferences.setString(_storageKey, jsonEncode(data));
  }
}
