import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/repositories/player_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/search/search_bloc.dart';
import '../cubit/locale/locale_cubit.dart';
import 'dart_basics_screen.dart';
import 'favorites_screen.dart';
import 'meta_screen.dart';
import 'search_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const List<Widget> _pages = [
    SearchScreen(),
    MetaScreen(),
    FavoritesScreen(),
    DartBasicsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => SearchBloc(context.read<PlayerRepository>()),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Павлов Никита Сергеевич',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 2),
              Text(
                'Пдо-37',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.language),
              tooltip: l10n.language,
              onSelected: (value) {
                final cubit = context.read<LocaleCubit>();
                if (value == 'ru') {
                  cubit.setLocale(const Locale('ru'));
                } else if (value == 'en') {
                  cubit.setLocale(const Locale('en'));
                } else {
                  cubit.setLocale(null);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'system',
                  child: Text(l10n.systemLanguage),
                ),
                PopupMenuItem(value: 'ru', child: Text(l10n.russian)),
                PopupMenuItem(value: 'en', child: Text(l10n.english)),
              ],
            ),
          ],
        ),
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.search),
              label: l10n.navSearch,
            ),
            NavigationDestination(
              icon: const Icon(Icons.insights),
              label: l10n.navMeta,
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_border),
              label: l10n.navFavorites,
            ),
            NavigationDestination(
              icon: const Icon(Icons.code),
              label: l10n.navDart,
            ),
          ],
        ),
      ),
    );
  }
}
