import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/hero.dart';
import '../../domain/entities/hero_stat.dart';
import '../../domain/entities/liked_item.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/meta/meta_bloc.dart';
import '../bloc/meta/meta_event.dart';
import '../bloc/meta/meta_state.dart';
import '../cubit/likes/likes_cubit.dart';
import '../cubit/likes/likes_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_view.dart';
import '../widgets/hero_card.dart';
import 'hero_detail_screen.dart';

class MetaScreen extends StatelessWidget {
  const MetaScreen({super.key});

  void _toggleLike(BuildContext context, MetaHero item) {
    final likes = context.read<LikesCubit>();
    final wasLiked = likes.state.isLiked(LikedType.hero, item.hero.id);
    likes.toggleHero(item.hero);

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

    return DefaultTabController(
      length: HeroLane.values.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.metaTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.metaSubtitle,
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.text,
            unselectedLabelColor: AppColors.muted,
            indicatorColor: AppColors.red,
            dividerColor: Colors.transparent,
            onTap: (index) {
              context.read<MetaBloc>().add(
                MetaLaneChanged(HeroLane.values[index]),
              );
            },
            tabs: [
              Tab(text: l10n.laneCarry),
              Tab(text: l10n.laneMid),
              Tab(text: l10n.laneOfflane),
              Tab(text: l10n.laneSupport),
              Tab(text: l10n.laneHardSupport),
            ],
          ),
          Expanded(
            child: BlocBuilder<MetaBloc, MetaState>(
              builder: (context, state) {
                if (state.status == MetaStatus.loading && state.items.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == MetaStatus.failure) {
                  return ErrorView(
                    title: l10n.networkErrorTitle,
                    text: l10n.networkErrorText,
                    retryLabel: l10n.retry,
                    onRetry: () =>
                        context.read<MetaBloc>().add(const MetaLoadRequested()),
                  );
                }

                final items = state.visibleItems;
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.insights,
                    title: l10n.noStats,
                    text: l10n.metaSubtitle,
                  );
                }

                return Stack(
                  children: [
                    BlocBuilder<LikesCubit, LikesState>(
                      builder: (context, likes) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            context.read<MetaBloc>().add(
                              const MetaRefreshRequested(),
                            );
                            await Future<void>.delayed(
                              const Duration(milliseconds: 900),
                            );
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return HeroCard(
                                item: item,
                                liked: likes.isLiked(
                                  LikedType.hero,
                                  item.hero.id,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => HeroDetailScreen(
                                        hero: item.hero,
                                        stat: item.stat,
                                      ),
                                    ),
                                  );
                                },
                                onLike: () => _toggleLike(context, item),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    if (state.status == MetaStatus.loading)
                      const Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator(minHeight: 2),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
