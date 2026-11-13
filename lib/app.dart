import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'domain/repositories/hero_repository.dart';
import 'domain/repositories/likes_repository.dart';
import 'domain/repositories/player_repository.dart';
import 'l10n/generated/app_localizations.dart';
import 'presentation/bloc/meta/meta_bloc.dart';
import 'presentation/bloc/meta/meta_event.dart';
import 'presentation/cubit/likes/likes_cubit.dart';
import 'presentation/cubit/locale/locale_cubit.dart';
import 'presentation/screens/home_shell.dart';

class DotaTrackerApp extends StatelessWidget {
  const DotaTrackerApp({
    super.key,
    required this.preferences,
    required this.playerRepository,
    required this.heroRepository,
    required this.likesRepository,
  });

  final SharedPreferences preferences;
  final PlayerRepository playerRepository;
  final HeroRepository heroRepository;
  final LikesRepository likesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PlayerRepository>.value(value: playerRepository),
        RepositoryProvider<HeroRepository>.value(value: heroRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LocaleCubit(preferences)),
          BlocProvider(create: (_) => LikesCubit(likesRepository)..load()),
          BlocProvider(
            create: (_) =>
                MetaBloc(heroRepository)..add(const MetaLoadRequested()),
          ),
        ],
        child: BlocBuilder<LocaleCubit, Locale?>(
          builder: (context, locale) {
            return MaterialApp(
              title: 'Dota 2 Tracker',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.dark,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const HomeShell(),
            );
          },
        ),
      ),
    );
  }
}
