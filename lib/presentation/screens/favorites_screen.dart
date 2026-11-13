import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/hero.dart' as domain;
import '../../domain/entities/liked_item.dart';
import '../../l10n/generated/app_localizations.dart';
import '../cubit/likes/likes_cubit.dart';
import '../cubit/likes/likes_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/remote_image.dart';
import 'hero_detail_screen.dart';
import 'player_profile_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _openItem(BuildContext context, LikedItem item) {
    if (item.type == LikedType.player) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              PlayerProfileScreen(accountId: item.id, initialName: item.name),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => HeroDetailScreen(
          hero: domain.Hero(
            id: item.id,
            name: item.name,
            localizedName: item.name,
            primaryAttr: '',
            attackType: '',
            roles: const [],
            imageUrl: item.imageUrl,
            iconUrl: item.imageUrl,
          ),
        ),
      ),
    );
  }

  void _remove(BuildContext context, LikedItem item) {
    context.read<LikesCubit>().remove(item);
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.likeRemoved),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<LikesCubit, LikesState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return EmptyState(
            icon: Icons.favorite_border,
            title: l10n.favoritesEmptyTitle,
            text: l10n.favoritesEmptyText,
          );
        }

        final players = state.byType(LikedType.player);
        final heroes = state.byType(LikedType.hero);

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
          children: [
            if (players.isNotEmpty) ...[
              _SectionTitle(title: l10n.playersSection, count: players.length),
              const SizedBox(height: 8),
              ...players.map(
                (item) => _FavoriteTile(
                  item: item,
                  onTap: () => _openItem(context, item),
                  onRemove: () => _remove(context, item),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (heroes.isNotEmpty) ...[
              _SectionTitle(title: l10n.heroesSection, count: heroes.length),
              const SizedBox(height: 8),
              ...heroes.map(
                (item) => _FavoriteTile(
                  item: item,
                  onTap: () => _openItem(context, item),
                  onRemove: () => _remove(context, item),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

  final LikedItem item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isPlayer = item.type == LikedType.player;

    return Card(
      color: AppColors.surface,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.surfaceLight),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RemoteImage(
                url: item.imageUrl,
                width: 52,
                height: 52,
                borderRadius: BorderRadius.circular(isPlayer ? 14 : 10),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    if (item.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
