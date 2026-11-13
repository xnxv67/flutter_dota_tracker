import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit(this._preferences) : super(_readLocale(_preferences));

  static const String _storageKey = 'app_locale';

  final SharedPreferences _preferences;

  static Locale? _readLocale(SharedPreferences preferences) {
    final code = preferences.getString(_storageKey);
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    emit(locale);
    if (locale == null) {
      await _preferences.remove(_storageKey);
    } else {
      await _preferences.setString(_storageKey, locale.languageCode);
    }
  }
}
