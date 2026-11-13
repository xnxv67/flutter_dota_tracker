import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/open_dota_api.dart';
import 'data/repositories/hero_repository_impl.dart';
import 'data/repositories/likes_repository_impl.dart';
import 'data/repositories/player_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final api = OpenDotaApi(createDio());

  runApp(
    DotaTrackerApp(
      preferences: preferences,
      playerRepository: PlayerRepositoryImpl(api),
      heroRepository: HeroRepositoryImpl(api),
      likesRepository: LikesRepositoryImpl(preferences),
    ),
  );
}
