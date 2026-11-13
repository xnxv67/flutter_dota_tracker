import 'package:equatable/equatable.dart';

enum HeroLane { carry, mid, offlane, support, hardSupport }

class Hero extends Equatable {
  const Hero({
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

  Set<HeroLane> get lanes {
    final values = roles.map((role) => role.toLowerCase()).toSet();
    final result = <HeroLane>{};

    if (values.contains('carry')) {
      result.add(HeroLane.carry);
    }

    if (values.contains('support')) {
      result.add(HeroLane.support);
      if (values.contains('disabler') ||
          values.contains('nuker') ||
          values.contains('durable')) {
        result.add(HeroLane.hardSupport);
      }
    }

    final core = !values.contains('carry') && !values.contains('support');

    if (core && values.contains('nuker')) {
      result.add(HeroLane.mid);
    }

    if (core && (values.contains('initiator') || values.contains('durable'))) {
      result.add(HeroLane.offlane);
    }

    if (result.isEmpty) {
      result.add(HeroLane.mid);
    }

    return result;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    localizedName,
    primaryAttr,
    attackType,
    roles,
    imageUrl,
    iconUrl,
  ];
}
