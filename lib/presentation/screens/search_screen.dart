import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/error/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/liked_item.dart';
import '../../domain/entities/player_summary.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart';
import '../bloc/search/search_state.dart';
import '../cubit/likes/likes_cubit.dart';
import '../cubit/likes/likes_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_view.dart';
import '../widgets/player_card.dart';
import 'dart_basics_screen.dart';
import 'player_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    context.read<SearchBloc>().add(SearchQueryChanged(value));
  }

  void _clear() {
    _controller.clear();
    setState(() {});
    context.read<SearchBloc>().add(const SearchCleared());
  }

  void _toggleLike(PlayerSummary player) {
    final likes = context.read<LikesCubit>();
    final wasLiked = likes.state.isLiked(LikedType.player, player.accountId);
    likes.togglePlayer(player);
    _showLikeMessage(wasLiked);
  }

  void _showLikeMessage(bool wasLiked) {
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

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: _SearchBanner(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: TextField(
            controller: _controller,
            onChanged: _onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: _clear,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const DartBasicsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.code, size: 18),
              label: Text(l10n.dartLabButton),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return _buildResults(state, l10n);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResults(SearchState state, AppLocalizations l10n) {
    if (state.status == SearchStatus.loading && state.players.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == SearchStatus.failure) {
      final isNotFound = state.error == AppErrorType.notFound;
      final isNetwork = state.error == AppErrorType.network;
      return ErrorView(
        title: isNotFound
            ? l10n.notFoundTitle
            : isNetwork
            ? l10n.networkErrorTitle
            : l10n.searchErrorTitle,
        text: isNotFound
            ? l10n.notFoundText
            : isNetwork
            ? l10n.networkErrorText
            : l10n.searchErrorText,
        retryLabel: l10n.retry,
        onRetry: () => context.read<SearchBloc>().add(const SearchRetried()),
      );
    }

    if (state.query.trim().isEmpty) {
      return EmptyState(
        icon: Icons.travel_explore,
        title: l10n.searchIntroTitle,
        text: l10n.searchIntroText,
      );
    }

    if (state.players.isEmpty && state.status == SearchStatus.success) {
      return EmptyState(
        icon: Icons.person_off_outlined,
        title: l10n.searchEmptyTitle,
        text: l10n.searchEmptyText,
      );
    }

    return Stack(
      children: [
        BlocBuilder<LikesCubit, LikesState>(
          builder: (context, likes) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SearchBloc>().add(const SearchRetried());
                await Future<void>.delayed(const Duration(milliseconds: 900));
              },
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.players.length,
                itemBuilder: (context, index) {
                  final player = state.players[index];
                  return PlayerCard(
                    player: player,
                    liked: likes.isLiked(LikedType.player, player.accountId),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PlayerProfileScreen(
                            accountId: player.accountId,
                            initialName: player.name,
                          ),
                        ),
                      );
                    },
                    onLike: () => _toggleLike(player),
                  );
                },
              ),
            );
          },
        ),
        if (state.isLoading)
          const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(minHeight: 2),
          ),
      ],
    );
  }
}

class _SearchBanner extends StatelessWidget {
  const _SearchBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 132,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF2A1315), Color(0xFF151B24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.red.withValues(alpha: 0.35)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -12,
            child: Opacity(
              opacity: 0.38,
              child: Image.asset(
                'assets/images/dota_logo.png',
                width: 132,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 190),
                child: Text(
                  AppLocalizations.of(context).appTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 190),
                child: Text(
                  AppLocalizations.of(context).metaSubtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12.5,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
