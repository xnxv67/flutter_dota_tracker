import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Dota 2 Tracker'**
  String get appTitle;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navMeta.
  ///
  /// In en, this message translates to:
  /// **'Meta'**
  String get navMeta;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navDart.
  ///
  /// In en, this message translates to:
  /// **'Dart'**
  String get navDart;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Nickname or Steam ID'**
  String get searchHint;

  /// No description provided for @searchByNickname.
  ///
  /// In en, this message translates to:
  /// **'Search by nickname or Steam ID'**
  String get searchByNickname;

  /// No description provided for @searchBySteamId.
  ///
  /// In en, this message translates to:
  /// **'Steam ID: 86745912 or 76561198047011640'**
  String get searchBySteamId;

  /// No description provided for @searchIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Find a Dota 2 player'**
  String get searchIntroTitle;

  /// No description provided for @searchIntroText.
  ///
  /// In en, this message translates to:
  /// **'Type a nickname or Steam ID. Results come from the OpenDota API.'**
  String get searchIntroText;

  /// No description provided for @searchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get searchEmptyTitle;

  /// No description provided for @searchEmptyText.
  ///
  /// In en, this message translates to:
  /// **'Check the spelling or try another nickname.'**
  String get searchEmptyText;

  /// No description provided for @searchErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load data'**
  String get searchErrorTitle;

  /// No description provided for @searchErrorText.
  ///
  /// In en, this message translates to:
  /// **'Check the internet connection and try again.'**
  String get searchErrorText;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @dartLabButton.
  ///
  /// In en, this message translates to:
  /// **'Lab 2: Dart basics'**
  String get dartLabButton;

  /// No description provided for @playerIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Player ID'**
  String get playerIdLabel;

  /// No description provided for @rankLabel.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rankLabel;

  /// No description provided for @winrateLabel.
  ///
  /// In en, this message translates to:
  /// **'Winrate'**
  String get winrateLabel;

  /// No description provided for @matchesLabel.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matchesLabel;

  /// No description provided for @winsLabel.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get winsLabel;

  /// No description provided for @lossesLabel.
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get lossesLabel;

  /// No description provided for @recentMatches.
  ///
  /// In en, this message translates to:
  /// **'Recent matches'**
  String get recentMatches;

  /// No description provided for @topHeroes.
  ///
  /// In en, this message translates to:
  /// **'Top heroes'**
  String get topHeroes;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches yet'**
  String get noMatches;

  /// No description provided for @noHeroes.
  ///
  /// In en, this message translates to:
  /// **'No hero data'**
  String get noHeroes;

  /// No description provided for @matchWin.
  ///
  /// In en, this message translates to:
  /// **'Win'**
  String get matchWin;

  /// No description provided for @matchLoss.
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get matchLoss;

  /// No description provided for @durationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationLabel;

  /// No description provided for @kdaLabel.
  ///
  /// In en, this message translates to:
  /// **'KDA'**
  String get kdaLabel;

  /// No description provided for @metaTitle.
  ///
  /// In en, this message translates to:
  /// **'Hero meta'**
  String get metaTitle;

  /// No description provided for @metaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Public matches, winrate by role'**
  String get metaSubtitle;

  /// No description provided for @laneCarry.
  ///
  /// In en, this message translates to:
  /// **'Carry'**
  String get laneCarry;

  /// No description provided for @laneMid.
  ///
  /// In en, this message translates to:
  /// **'Mid'**
  String get laneMid;

  /// No description provided for @laneOfflane.
  ///
  /// In en, this message translates to:
  /// **'Offlane'**
  String get laneOfflane;

  /// No description provided for @laneSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get laneSupport;

  /// No description provided for @laneHardSupport.
  ///
  /// In en, this message translates to:
  /// **'Hard Support'**
  String get laneHardSupport;

  /// No description provided for @picksLabel.
  ///
  /// In en, this message translates to:
  /// **'Picks'**
  String get picksLabel;

  /// No description provided for @heroesLabel.
  ///
  /// In en, this message translates to:
  /// **'Heroes'**
  String get heroesLabel;

  /// No description provided for @heroDetails.
  ///
  /// In en, this message translates to:
  /// **'Hero details'**
  String get heroDetails;

  /// No description provided for @rolesLabel.
  ///
  /// In en, this message translates to:
  /// **'Roles'**
  String get rolesLabel;

  /// No description provided for @attackLabel.
  ///
  /// In en, this message translates to:
  /// **'Attack'**
  String get attackLabel;

  /// No description provided for @attributeLabel.
  ///
  /// In en, this message translates to:
  /// **'Attribute'**
  String get attributeLabel;

  /// No description provided for @statsLabel.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsLabel;

  /// No description provided for @likeAdded.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get likeAdded;

  /// No description provided for @likeRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get likeRemoved;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptyText.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on a player or hero card.'**
  String get favoritesEmptyText;

  /// No description provided for @playersSection.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get playersSection;

  /// No description provided for @heroesSection.
  ///
  /// In en, this message translates to:
  /// **'Heroes'**
  String get heroesSection;

  /// No description provided for @dartTitle.
  ///
  /// In en, this message translates to:
  /// **'Dart basics'**
  String get dartTitle;

  /// No description provided for @dartIntro.
  ///
  /// In en, this message translates to:
  /// **'A small example for lab 2: classes, enum, loops, generics, anonymous functions, Future and extension.'**
  String get dartIntro;

  /// No description provided for @runExample.
  ///
  /// In en, this message translates to:
  /// **'Run example'**
  String get runExample;

  /// No description provided for @runningLabel.
  ///
  /// In en, this message translates to:
  /// **'Running...'**
  String get runningLabel;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get resultTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemLanguage;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Player not found'**
  String get notFoundTitle;

  /// No description provided for @notFoundText.
  ///
  /// In en, this message translates to:
  /// **'OpenDota does not know this ID. Check the number and try again.'**
  String get notFoundText;

  /// No description provided for @networkErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get networkErrorTitle;

  /// No description provided for @networkErrorText.
  ///
  /// In en, this message translates to:
  /// **'The API did not respond. Try again in a minute.'**
  String get networkErrorText;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get unknownError;

  /// No description provided for @rankHerald.
  ///
  /// In en, this message translates to:
  /// **'Herald'**
  String get rankHerald;

  /// No description provided for @rankGuardian.
  ///
  /// In en, this message translates to:
  /// **'Guardian'**
  String get rankGuardian;

  /// No description provided for @rankCrusader.
  ///
  /// In en, this message translates to:
  /// **'Crusader'**
  String get rankCrusader;

  /// No description provided for @rankArchon.
  ///
  /// In en, this message translates to:
  /// **'Archon'**
  String get rankArchon;

  /// No description provided for @rankLegend.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get rankLegend;

  /// No description provided for @rankAncient.
  ///
  /// In en, this message translates to:
  /// **'Ancient'**
  String get rankAncient;

  /// No description provided for @rankDivine.
  ///
  /// In en, this message translates to:
  /// **'Divine'**
  String get rankDivine;

  /// No description provided for @rankImmortal.
  ///
  /// In en, this message translates to:
  /// **'Immortal'**
  String get rankImmortal;

  /// No description provided for @rankUncalibrated.
  ///
  /// In en, this message translates to:
  /// **'Uncalibrated'**
  String get rankUncalibrated;

  /// No description provided for @playerProfile.
  ///
  /// In en, this message translates to:
  /// **'Player profile'**
  String get playerProfile;

  /// No description provided for @openProfile.
  ///
  /// In en, this message translates to:
  /// **'Open profile'**
  String get openProfile;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @searchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchButton;

  /// No description provided for @steamIdExample.
  ///
  /// In en, this message translates to:
  /// **'Steam ID example'**
  String get steamIdExample;

  /// No description provided for @labOneLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 1: AppBar and Git'**
  String get labOneLabel;

  /// No description provided for @labTwoLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 2: Dart basics'**
  String get labTwoLabel;

  /// No description provided for @labThreeLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 3: Card list'**
  String get labThreeLabel;

  /// No description provided for @labFourLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 4: Likes and details'**
  String get labFourLabel;

  /// No description provided for @labFiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 5: API, DTO, repositories'**
  String get labFiveLabel;

  /// No description provided for @labSixLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 6: BLoC, debounce, refresh'**
  String get labSixLabel;

  /// No description provided for @labSevenLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab 7: Icon, localization, SharedPreferences'**
  String get labSevenLabel;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get aboutApp;

  /// No description provided for @aboutText.
  ///
  /// In en, this message translates to:
  /// **'Educational Dota 2 tracker. Data: OpenDota API. The app is not affiliated with Valve.'**
  String get aboutText;

  /// No description provided for @likedPlayers.
  ///
  /// In en, this message translates to:
  /// **'Liked players'**
  String get likedPlayers;

  /// No description provided for @likedHeroes.
  ///
  /// In en, this message translates to:
  /// **'Liked heroes'**
  String get likedHeroes;

  /// No description provided for @emptyFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Your favorites are stored on this device.'**
  String get emptyFavoritesHint;

  /// No description provided for @allRoles.
  ///
  /// In en, this message translates to:
  /// **'All roles'**
  String get allRoles;

  /// No description provided for @noStats.
  ///
  /// In en, this message translates to:
  /// **'No statistics'**
  String get noStats;

  /// No description provided for @bestWinrate.
  ///
  /// In en, this message translates to:
  /// **'Best winrate'**
  String get bestWinrate;

  /// No description provided for @totalPicks.
  ///
  /// In en, this message translates to:
  /// **'Total picks'**
  String get totalPicks;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
