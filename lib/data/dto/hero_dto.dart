import '../../core/constants/api_constants.dart';
import '../../domain/entities/hero.dart';

class HeroDto {
  const HeroDto({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.imageUrl,
    required this.iconUrl,
  });

  final int id;
  final String name;
  final String localizedName;
  final String primaryAttr;
  final String attackType;
  final List<String> roles;
  final String imageUrl;
  final String iconUrl;

  factory HeroDto.fromJson(Map<String, dynamic> json) {
    final roles =
        (json['roles'] as List<dynamic>?)
            ?.map((role) => role.toString())
            .toList() ??
        const <String>[];
    final name = json['name']?.toString() ?? '';
    final shortName = name.replaceFirst('npc_dota_hero_', '');

    return HeroDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: name,
      localizedName: json['localized_name']?.toString() ?? '',
      primaryAttr: json['primary_attr']?.toString() ?? '',
      attackType: json['attack_type']?.toString() ?? '',
      roles: roles,
      imageUrl: _absoluteImage(
        json['img']?.toString(),
        '/apps/dota2/images/dota_react/heroes/$shortName.png',
      ),
      iconUrl: _absoluteImage(
        json['icon']?.toString(),
        '/apps/dota2/images/dota_react/heroes/icons/$shortName.png',
      ),
    );
  }

  Hero toEntity() {
    return Hero(
      id: id,
      name: name,
      localizedName: localizedName.isEmpty ? name : localizedName,
      primaryAttr: primaryAttr,
      attackType: attackType,
      roles: roles,
      imageUrl: imageUrl,
      iconUrl: iconUrl,
    );
  }

  static String _absoluteImage(String? raw, String fallbackPath) {
    final value = raw == null || raw.isEmpty ? fallbackPath : raw;
    final clean = value.endsWith('?')
        ? value.substring(0, value.length - 1)
        : value;
    if (clean.startsWith('http')) {
      return clean;
    }
    return '${ApiConstants.cdnBase}$clean';
  }
}
