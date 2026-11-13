import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

class DartBasicsScreen extends StatelessWidget {
  const DartBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).dartTitle)),
      body: const DartBasicsView(),
    );
  }
}

class DartBasicsView extends StatefulWidget {
  const DartBasicsView({super.key});

  @override
  State<DartBasicsView> createState() => _DartBasicsViewState();
}

class _DartBasicsViewState extends State<DartBasicsView> {
  bool _running = false;
  String _result = '';

  Future<void> _run() async {
    setState(() {
      _running = true;
      _result = '';
    });

    final result = await _buildReport();

    if (!mounted) {
      return;
    }

    setState(() {
      _running = false;
      _result = result;
    });
  }

  Future<String> _buildReport() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    final heroes = <_DemoHero>[
      _DemoHero('Juggernaut', _DemoRole.carry),
      _DemoHero('Puck', _DemoRole.mid),
      _DemoHero('Mars', _DemoRole.offlane),
      _DemoHero('Crystal Maiden', _DemoRole.support),
    ];

    final results = <bool>[true, true, false, true];
    var index = 0;
    while (index < heroes.length) {
      heroes[index].addGame(won: results[index]);
      index++;
    }

    for (final hero in heroes) {
      hero.addGame(won: hero.role != _DemoRole.offlane);
    }

    final team = _Team<_DemoHero>(heroes);
    final best = heroes.where((hero) => hero.winRate >= 0.5).toList();
    final names = best.map((hero) => hero.cardTitle).join(', ');

    return 'Команда: ${team.members.length} героя, '
        'сыграно матчей: ${team.totalGames}.\n'
        'Лучшие по винрейту: $names.\n'
        'Средний винрейт: ${team.averageWinrate.toStringAsFixed(1)}%.';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: [
        Text(
          l10n.dartTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.dartIntro,
          style: const TextStyle(color: AppColors.muted, height: 1.4),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F141B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          child: const SelectableText(
            _sourceExample,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
              color: Color(0xFFD7E0EA),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _running ? null : _run,
          icon: _running
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.play_arrow),
          label: Text(_running ? l10n.runningLabel : l10n.runExample),
        ),
        if (_result.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.green.withValues(alpha: 0.35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.resultTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_result, style: const TextStyle(height: 1.5)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

enum _DemoRole { carry, mid, offlane, support }

class _DemoHero {
  _DemoHero(this.name, this.role);

  final String name;
  final _DemoRole role;
  int games = 0;
  int wins = 0;

  double get winRate => games == 0 ? 0 : wins / games;

  void addGame({required bool won}) {
    games++;
    if (won) {
      wins++;
    }
  }
}

extension _DemoHeroX on _DemoHero {
  String get cardTitle => '$name (${role.name})';
}

class _Team<T extends _DemoHero> {
  _Team(this.members);

  final List<T> members;

  int get totalGames => members.fold(0, (total, hero) => total + hero.games);

  double get averageWinrate {
    if (members.isEmpty) {
      return 0;
    }
    final total = members.fold<double>(0, (sum, hero) => sum + hero.winRate);
    return total / members.length * 100;
  }
}

const String _sourceExample = r'''
enum DemoRole { carry, mid, offlane, support }

class DemoHero {
  DemoHero(this.name, this.role);

  final String name;
  final DemoRole role;
  int games = 0;
  int wins = 0;

  double get winRate => games == 0 ? 0 : wins / games;

  void addGame({required bool won}) {
    games++;
    if (won) wins++;
  }
}

extension DemoHeroX on DemoHero {
  String get cardTitle => '$name (${role.name})';
}

class Team<T extends DemoHero> {
  Team(this.members);
  final List<T> members;

  int get totalGames =>
      members.fold(0, (total, hero) => total + hero.games);
}

Future<String> buildReport() async {
  await Future<void>.delayed(const Duration(milliseconds: 600));

  final heroes = <DemoHero>[
    DemoHero('Juggernaut', DemoRole.carry),
    DemoHero('Puck', DemoRole.mid),
    DemoHero('Mars', DemoRole.offlane),
    DemoHero('Crystal Maiden', DemoRole.support),
  ];

  for (final hero in heroes) {
    hero.addGame(won: hero.role != DemoRole.offlane);
  }

  final best = heroes.where((hero) => hero.winRate >= 0.5).toList();
  return best.map((hero) => hero.cardTitle).join(', ');
}
''';
