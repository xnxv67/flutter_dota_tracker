// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dota 2 Tracker';

  @override
  String get navSearch => 'Search';

  @override
  String get navMeta => 'Meta';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navDart => 'Dart';

  @override
  String get searchHint => 'Nickname or Steam ID';

  @override
  String get searchByNickname => 'Search by nickname or Steam ID';

  @override
  String get searchBySteamId => 'Steam ID: 86745912 or 76561198047011640';

  @override
  String get searchIntroTitle => 'Find a Dota 2 player';

  @override
  String get searchIntroText =>
      'Type a nickname or Steam ID. Results come from the OpenDota API.';

  @override
  String get searchEmptyTitle => 'Nothing found';

  @override
  String get searchEmptyText => 'Check the spelling or try another nickname.';

  @override
  String get searchErrorTitle => 'Could not load data';

  @override
  String get searchErrorText => 'Check the internet connection and try again.';

  @override
  String get retry => 'Retry';

  @override
  String get dartLabButton => 'Lab 2: Dart basics';

  @override
  String get playerIdLabel => 'Player ID';

  @override
  String get rankLabel => 'Rank';

  @override
  String get winrateLabel => 'Winrate';

  @override
  String get matchesLabel => 'Matches';

  @override
  String get winsLabel => 'Wins';

  @override
  String get lossesLabel => 'Losses';

  @override
  String get recentMatches => 'Recent matches';

  @override
  String get topHeroes => 'Top heroes';

  @override
  String get noMatches => 'No matches yet';

  @override
  String get noHeroes => 'No hero data';

  @override
  String get matchWin => 'Win';

  @override
  String get matchLoss => 'Loss';

  @override
  String get durationLabel => 'Duration';

  @override
  String get kdaLabel => 'KDA';

  @override
  String get metaTitle => 'Hero meta';

  @override
  String get metaSubtitle => 'Public matches, winrate by role';

  @override
  String get laneCarry => 'Carry';

  @override
  String get laneMid => 'Mid';

  @override
  String get laneOfflane => 'Offlane';

  @override
  String get laneSupport => 'Support';

  @override
  String get laneHardSupport => 'Hard Support';

  @override
  String get picksLabel => 'Picks';

  @override
  String get heroesLabel => 'Heroes';

  @override
  String get heroDetails => 'Hero details';

  @override
  String get rolesLabel => 'Roles';

  @override
  String get attackLabel => 'Attack';

  @override
  String get attributeLabel => 'Attribute';

  @override
  String get statsLabel => 'Statistics';

  @override
  String get likeAdded => 'Added to favorites';

  @override
  String get likeRemoved => 'Removed from favorites';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get favoritesEmptyTitle => 'Nothing saved yet';

  @override
  String get favoritesEmptyText => 'Tap the heart on a player or hero card.';

  @override
  String get playersSection => 'Players';

  @override
  String get heroesSection => 'Heroes';

  @override
  String get dartTitle => 'Dart basics';

  @override
  String get dartIntro =>
      'A small example for lab 2: classes, enum, loops, generics, anonymous functions, Future and extension.';

  @override
  String get runExample => 'Run example';

  @override
  String get runningLabel => 'Running...';

  @override
  String get resultTitle => 'Result';

  @override
  String get language => 'Language';

  @override
  String get russian => 'Russian';

  @override
  String get english => 'English';

  @override
  String get systemLanguage => 'System';

  @override
  String get notFoundTitle => 'Player not found';

  @override
  String get notFoundText =>
      'OpenDota does not know this ID. Check the number and try again.';

  @override
  String get networkErrorTitle => 'Network error';

  @override
  String get networkErrorText =>
      'The API did not respond. Try again in a minute.';

  @override
  String get unknownError => 'Something went wrong';

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
  String get rankUncalibrated => 'Uncalibrated';

  @override
  String get playerProfile => 'Player profile';

  @override
  String get openProfile => 'Open profile';

  @override
  String get remove => 'Remove';

  @override
  String get close => 'Close';

  @override
  String get searchButton => 'Search';

  @override
  String get steamIdExample => 'Steam ID example';

  @override
  String get labOneLabel => 'Lab 1: AppBar and Git';

  @override
  String get labTwoLabel => 'Lab 2: Dart basics';

  @override
  String get labThreeLabel => 'Lab 3: Card list';

  @override
  String get labFourLabel => 'Lab 4: Likes and details';

  @override
  String get labFiveLabel => 'Lab 5: API, DTO, repositories';

  @override
  String get labSixLabel => 'Lab 6: BLoC, debounce, refresh';

  @override
  String get labSevenLabel => 'Lab 7: Icon, localization, SharedPreferences';

  @override
  String get aboutApp => 'About the app';

  @override
  String get aboutText =>
      'Educational Dota 2 tracker. Data: OpenDota API. The app is not affiliated with Valve.';

  @override
  String get likedPlayers => 'Liked players';

  @override
  String get likedHeroes => 'Liked heroes';

  @override
  String get emptyFavoritesHint => 'Your favorites are stored on this device.';

  @override
  String get allRoles => 'All roles';

  @override
  String get noStats => 'No statistics';

  @override
  String get bestWinrate => 'Best winrate';

  @override
  String get totalPicks => 'Total picks';

  @override
  String get loading => 'Loading...';
}
