import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/hero.dart' as domain;
import '../../domain/entities/hero_stat.dart';
import '../../domain/entities/liked_item.dart';
import '../../l10n/generated/app_localizations.dart';
import '../cubit/likes/likes_cubit.dart';
import '../cubit/likes/likes_state.dart';
import '../widgets/remote_image.dart';

class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key, required this.hero, this.stat});

  final domain.Hero hero;
  final HeroStat? stat;

  void _toggleLike(BuildContext context) {
    final likes = context.read<LikesCubit>();
    final wasLiked = likes.state.isLiked(LikedType.hero, hero.id);
    likes.toggleHero(hero);

    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(wasLiked ? l10n.likeRemoved : l10n.likeAdded),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(hero.localizedName),
        actions: [
          BlocBuilder<LikesCubit, LikesState>(
            builder: (context, state) {
              final liked = state.isLiked(LikedType.hero, hero.id);
              return IconButton(
                onPressed: () => _toggleLike(context),
                icon: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  color: liked ? AppColors.red : null,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                RemoteImage(
                  url: hero.imageUrl,
                  width: double.infinity,
                  height: 230,
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.background.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 14,
                  child: Text(
                    hero.localizedName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: hero.roles
                .map(
                  (role) => Chip(
                    label: Text(role),
                    backgroundColor: AppColors.surface,
                    side: const BorderSide(color: AppColors.surfaceLight),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          _InfoCard(
            title: l10n.statsLabel,
            children: [
              _InfoRow(
                label: l10n.winrateLabel,
                value: stat == null
                    ? l10n.noStats
                    : formatPercent(stat!.winRate),
                valueColor: stat == null
                    ? AppColors.muted
                    : (stat!.winRate >= 0.5 ? AppColors.green : AppColors.red),
              ),
              _InfoRow(
                label: l10n.picksLabel,
                value: stat == null ? '—' : '${stat!.picks}',
              ),
              _InfoRow(label: l10n.attackLabel, value: hero.attackType),
              _InfoRow(label: l10n.attributeLabel, value: hero.primaryAttr),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          const Spacer(),
          Text(
            value.isEmpty ? '—' : value,
            style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }
}
