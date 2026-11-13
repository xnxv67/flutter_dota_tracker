import 'package:equatable/equatable.dart';

enum LikedType { hero, player }

class LikedItem extends Equatable {
  const LikedItem({
    required this.id,
    required this.type,
    required this.name,
    required this.imageUrl,
    required this.subtitle,
  });

  final int id;
  final LikedType type;
  final String name;
  final String imageUrl;
  final String subtitle;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'name': name,
      'imageUrl': imageUrl,
      'subtitle': subtitle,
    };
  }

  factory LikedItem.fromJson(Map<String, dynamic> json) {
    final typeName = json['type']?.toString() ?? LikedType.hero.name;
    return LikedItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: typeName == LikedType.player.name
          ? LikedType.player
          : LikedType.hero,
      name: json['name']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [id, type, name, imageUrl, subtitle];
}
