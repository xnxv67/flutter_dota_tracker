// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Dota 2 Tracker';

  @override
  String get navSearch => 'Поиск';

  @override
  String get navMeta => 'Мета';

  @override
  String get navFavorites => 'Избранное';

  @override
  String get navDart => 'Dart';

  @override
  String get searchHint => 'Ник или Steam ID';

  @override
  String get searchByNickname => 'Поиск по нику или Steam ID';

  @override
  String get searchBySteamId => 'Steam ID: 86745912 или 76561198047011640';

  @override
  String get searchIntroTitle => 'Найди игрока в Dota 2';

  @override
  String get searchIntroText =>
      'Введи ник или Steam ID. Данные приходят из OpenDota API.';

  @override
  String get searchEmptyTitle => 'Ничего не найдено';

  @override
  String get searchEmptyText => 'Проверь написание или попробуй другой ник.';

  @override
  String get searchErrorTitle => 'Не удалось загрузить данные';

  @override
  String get searchErrorText => 'Проверь интернет и попробуй ещё раз.';

  @override
  String get retry => 'Повторить';

  @override
  String get dartLabButton => 'Лаба 2: основы Dart';

  @override
  String get playerIdLabel => 'ID игрока';

  @override
  String get rankLabel => 'Ранг';

  @override
  String get winrateLabel => 'Винрейт';

  @override
  String get matchesLabel => 'Матчей';

  @override
  String get winsLabel => 'Победы';

  @override
  String get lossesLabel => 'Поражения';

  @override
  String get recentMatches => 'Последние матчи';

  @override
  String get topHeroes => 'Топ героев';

  @override
  String get noMatches => 'Матчей пока нет';

  @override
  String get noHeroes => 'Нет данных по героям';

  @override
  String get matchWin => 'Победа';

  @override
  String get matchLoss => 'Поражение';

  @override
  String get durationLabel => 'Длительность';

  @override
  String get kdaLabel => 'KDA';

  @override
  String get metaTitle => 'Мета героев';

  @override
  String get metaSubtitle => 'Публичные матчи, винрейт по ролям';

  @override
  String get laneCarry => 'Керри';

  @override
  String get laneMid => 'Мид';

  @override
  String get laneOfflane => 'Оффлейн';

  @override
  String get laneSupport => 'Саппорт';

  @override
  String get laneHardSupport => 'Фулл саппорт';

  @override
  String get picksLabel => 'Пиков';

  @override
  String get heroesLabel => 'Герои';

  @override
  String get heroDetails => 'Детали героя';

  @override
  String get rolesLabel => 'Роли';

  @override
  String get attackLabel => 'Атака';

  @override
  String get attributeLabel => 'Атрибут';

  @override
  String get statsLabel => 'Статистика';

  @override
  String get likeAdded => 'Добавлено в избранное';

  @override
  String get likeRemoved => 'Удалено из избранного';

  @override
  String get favoritesTitle => 'Избранное';

  @override
  String get favoritesEmptyTitle => 'Пока пусто';

  @override
  String get favoritesEmptyText =>
      'Нажми на сердечко на карточке игрока или героя.';

  @override
  String get playersSection => 'Игроки';

  @override
  String get heroesSection => 'Герои';

  @override
  String get dartTitle => 'Основы Dart';

  @override
  String get dartIntro =>
      'Небольшой пример для лабы 2: классы, enum, циклы, generics, анонимные функции, Future и extension.';

  @override
  String get runExample => 'Запустить пример';

  @override
  String get runningLabel => 'Выполняется...';

  @override
  String get resultTitle => 'Результат';

  @override
  String get language => 'Язык';

  @override
  String get russian => 'Русский';

  @override
  String get english => 'English';

  @override
  String get systemLanguage => 'Системный';

  @override
  String get notFoundTitle => 'Игрок не найден';

  @override
  String get notFoundText =>
      'OpenDota не знает такой ID. Проверь номер и попробуй снова.';

  @override
  String get networkErrorTitle => 'Ошибка сети';

  @override
  String get networkErrorText => 'API не ответил. Попробуй через минуту.';

  @override
  String get unknownError => 'Что-то пошло не так';

  @override
  String get rankHerald => 'Herald';

  @override
  String get rankGuardian => 'Guardian';

  @override
  String get rankCrusader => 'Crusader';

  @override
  String get rankArchon => 'Archon';

  @override
  String get rankLegend => 'Legend';

  @override
  String get rankAncient => 'Ancient';

  @override
  String get rankDivine => 'Divine';

  @override
  String get rankImmortal => 'Immortal';

  @override
  String get rankUncalibrated => 'Без калибровки';

  @override
  String get playerProfile => 'Профиль игрока';

  @override
  String get openProfile => 'Открыть профиль';

  @override
  String get remove => 'Удалить';

  @override
  String get close => 'Закрыть';

  @override
  String get searchButton => 'Найти';

  @override
  String get steamIdExample => 'Пример Steam ID';

  @override
  String get labOneLabel => 'Лаба 1: AppBar и Git';

  @override
  String get labTwoLabel => 'Лаба 2: основы Dart';

  @override
  String get labThreeLabel => 'Лаба 3: список карточек';

  @override
  String get labFourLabel => 'Лаба 4: лайки и детали';

  @override
  String get labFiveLabel => 'Лаба 5: API, DTO, репозитории';

  @override
  String get labSixLabel => 'Лаба 6: BLoC, debounce, обновление';

  @override
  String get labSevenLabel => 'Лаба 7: иконка, локализация, SharedPreferences';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get aboutText =>
      'Учебный трекер Dota 2. Данные: OpenDota API. Приложение не связано с Valve.';

  @override
  String get likedPlayers => 'Избранные игроки';

  @override
  String get likedHeroes => 'Избранные герои';

  @override
  String get emptyFavoritesHint => 'Избранное хранится на этом устройстве.';

  @override
  String get allRoles => 'Все роли';

  @override
  String get noStats => 'Нет статистики';

  @override
  String get bestWinrate => 'Лучший винрейт';

  @override
  String get totalPicks => 'Всего пиков';

  @override
  String get loading => 'Загрузка...';
}
