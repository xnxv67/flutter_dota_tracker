import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/player_hero.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/entities/recent_match.dart';
import '../../domain/repositories/player_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../widgets/error_view.dart';
import '../widgets/remote_image.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({
    super.key,
    required this.accountId,
    required this.initialName,
  });

  final int accountId;
  final String initialName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileBloc(context.read<PlayerRepository>())
            ..add(ProfileLoadRequested(accountId)),
      child: Scaffold(
        appBar: AppBar(title: Text(initialName)),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final l10n = AppLocalizations.of(context);

            if (state.profile == null &&
                state.status == ProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ProfileStatus.failure) {
              return ErrorView(
                title: l10n.networkErrorTitle,
                text: l10n.networkErrorText,
                retryLabel: l10n.retry,
                onRetry: () => context.read<ProfileBloc>().add(
                  ProfileLoadRequested(accountId),
                ),
              );
            }

            final profile = state.profile;
            if (profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(
                  const ProfileRefreshRequested(),
                );
                await Future<void>.delayed(const Duration(milliseconds: 900));
              },
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  _ProfileHeader(profile: profile),
                  const SizedBox(height: 14),
                  _WinrateCard(profile: profile),
                  const SizedBox(height: 20),
                  _SectionTitle(
                    title: l10n.topHeroes,
                    icon: Icons.military_tech,
                  ),
                  const SizedBox(height: 10),
                  _TopHeroes(
                    heroes: profile.topHeroes,
                    emptyText: l10n.noHeroes,
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle(title: l10n.recentMatches, icon: Icons.history),
                  const SizedBox(height: 10),
                  if (profile.recentMatches.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        l10n.noMatches,
                        style: const TextStyle(color: AppColors.muted),
                      ),
                    )
                  else
                    ...profile.recentMatches.map(
                      (match) => _MatchTile(match: match),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF2A1315), Color(0xFF151B24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          RemoteImage(
            url: profile.avatarUrl,
            width: 82,
            height: 82,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID ${profile.accountId}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _Badge(
                      icon: Icons.military_tech,
                      text: _rankName(profile.rankTier, l10n),
                      color: _rankColor(profile.rankTier),
                    ),
                    if (profile.leaderboardRank != null)
                      _Badge(
                        icon: Icons.leaderboard,
                        text: 'Top ${profile.leaderboardRank}',
                        color: AppColors.gold,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _rankName(int rankTier, AppLocalizations l10n) {
    if (rankTier <= 0) {
      return l10n.rankUncalibrated;
    }

    final medal = rankTier ~/ 10;
    final star = rankTier % 10;
    final names = [
      l10n.rankUncalibrated,
      l10n.rankHerald,
      l10n.rankGuardian,
      l10n.rankCrusader,
      l10n.rankArchon,
      l10n.rankLegend,
      l10n.rankAncient,
      l10n.rankDivine,
      l10n.rankImmortal,
    ];
    final name = medal >= 1 && medal < names.length
        ? names[medal]
        : l10n.rankUncalibrated;
    return star > 0 ? '$name $star' : name;
  }

  Color _rankColor(int rankTier) {
    switch (rankTier ~/ 10) {
      case 1:
        return const Color(0xFF9AA4B2);
      case 2:
        return const Color(0xFFB8C4D0);
      case 3:
        return const Color(0xFFD9A441);
      case 4:
        return const Color(0xFF4CC38A);
      case 5:
        return const Color(0xFF5B9BFF);
      case 6:
        return const Color(0xFFA78BFA);
      case 7:
        return const Color(0xFFE5484D);
      case 8:
        return const Color(0xFFF2C94C);
      default:
        return AppColors.muted;
    }
  }
}

class _WinrateCard extends StatelessWidget {
  const _WinrateCard({required this.profile});

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.winrateLabel,
                style: const TextStyle(color: AppColors.muted),
              ),
              const Spacer(),
              Text(
                formatPercent(profile.winRate),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: profile.winRate,
              minHeight: 8,
              backgroundColor: AppColors.surfaceLight,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _Stat(
                value: '${profile.wins}',
                label: l10n.winsLabel,
                color: AppColors.green,
              ),
              _Stat(
                value: '${profile.losses}',
                label: l10n.lossesLabel,
                color: AppColors.red,
              ),
              _Stat(
                value: '${profile.totalGames}',
                label: l10n.matchesLabel,
                color: AppColors.text,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.gold),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _TopHeroes extends StatelessWidget {
  const _TopHeroes({required this.heroes, required this.emptyText});

  final List<PlayerHero> heroes;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    if (heroes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(18),
        child: Text(emptyText, style: const TextStyle(color: AppColors.muted)),
      );
    }

    return SizedBox(
      height: 158,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: heroes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = heroes[index];
          return Container(
            width: 108,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.surfaceLight),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RemoteImage(url: item.hero.imageUrl, width: 108, height: 76),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.hero.localizedName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${item.games} · ${formatPercent(item.winRate)}',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MatchTile extends StatelessWidget {
  const _MatchTile({required this.match});

  final RecentMatch match;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = match.win ? AppColors.green : AppColors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          RemoteImage(
            url: match.hero.imageUrl,
            width: 48,
            height: 48,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.hero.localizedName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  '${formatDate(match.startTime)} · ${formatDuration(match.duration)}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatKda(match.kills, match.deaths, match.assists),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                match.win ? l10n.matchWin : l10n.matchLoss,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
