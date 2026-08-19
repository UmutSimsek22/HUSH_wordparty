import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/hush_card.dart';
import '../models/player.dart';
import '../models/team.dart';
import '../models/game_settings.dart';
import '../models/game_stats.dart';
import '../services/sound_service.dart';

class GameProvider extends ChangeNotifier {
  List<Team> _teams = [];
  GameSettings _settings = GameSettings();
  final SoundService _soundService = SoundService();

  List<HushCard> _allCards = [];
  List<HushCard> _drawPile = [];
  HushCard? _currentCard;

  int _currentRound = 1;
  int _currentTeamIndex = 0;
  final Map<String, int> _teamPlayerIndices = {}; // teamId -> playerIndex

  int _remainingSeconds = 60;
  int _remainingPasses = 3;
  Timer? _timer;
  bool _isTurnActive = false;
  bool _isGameFinished = false;

  // Turn statistics
  int _turnCorrect = 0;
  int _turnHush = 0;
  int _turnPass = 0;

  // Getters
  List<Team> get teams => _teams;
  GameSettings get settings => _settings;
  HushCard? get currentCard => _currentCard;
  int get currentRound => _currentRound;
  int get currentTeamIndex => _currentTeamIndex;
  int get remainingSeconds => _remainingSeconds;
  int get remainingPasses => _remainingPasses;
  bool get isTurnActive => _isTurnActive;
  bool get isGameFinished => _isGameFinished;
  int get turnCorrect => _turnCorrect;
  int get turnHush => _turnHush;
  int get turnPass => _turnPass;
  int get turnNetPoints => _turnCorrect - _turnHush;

  Team? get currentTeam {
    if (_teams.isEmpty || _currentTeamIndex >= _teams.length) return null;
    return _teams[_currentTeamIndex];
  }

  Player? get currentDescriber {
    final team = currentTeam;
    if (team == null || team.players.isEmpty) return null;
    final playerIdx = _teamPlayerIndices[team.id] ?? 0;
    return team.players[playerIdx % team.players.length];
  }

  bool get canPass {
    if (_settings.isUnlimitedPass) return true;
    return _remainingPasses > 0;
  }

  // Load word cards from JSON assets
  Future<void> loadCards() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/words.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _allCards = jsonList.map((item) => HushCard.fromJson(item)).toList();
      _drawPile = List.from(_allCards)..shuffle();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading cards: $e');
    }
  }

  void setupDefaultTeams() {
    _teams = [
      Team(
        id: 'team_1',
        name: 'Kırmızı Takım',
        color: const Color(0xFFFF4D4D),
        players: [
          Player(id: 'p1_1', name: 'Rüzgar', teamId: 'team_1'),
          Player(id: 'p1_2', name: 'Enes', teamId: 'team_1'),
        ],
      ),
      Team(
        id: 'team_2',
        name: 'Mavi Takım',
        color: const Color(0xFF00A8FF),
        players: [
          Player(id: 'p2_1', name: 'İrem', teamId: 'team_2'),
          Player(id: 'p2_2', name: 'Elif', teamId: 'team_2'),
        ],
      ),
    ];
    _initPlayerIndices();
    notifyListeners();
  }

  void setTeams(List<Team> newTeams) {
    _teams = newTeams;
    _initPlayerIndices();
    notifyListeners();
  }

  void updateSettings(GameSettings newSettings) {
    _settings = newSettings;
    _soundService.isSoundEnabled = newSettings.isSoundEnabled;
    _soundService.isVibrationEnabled = newSettings.isVibrationEnabled;
    notifyListeners();
  }

  void _initPlayerIndices() {
    _teamPlayerIndices.clear();
    for (var team in _teams) {
      _teamPlayerIndices[team.id] = 0;
    }
  }

  void _drawNextCard() {
    if (_drawPile.isEmpty) {
      _drawPile = List.from(_allCards)..shuffle();
    }
    if (_drawPile.isNotEmpty) {
      _currentCard = _drawPile.removeLast();
    }
  }

  void startTurn() {
    _timer?.cancel();
    _remainingSeconds = _settings.timePerTurnSeconds;
    _remainingPasses = _settings.passLimit ?? 999;
    _turnCorrect = 0;
    _turnHush = 0;
    _turnPass = 0;
    _isTurnActive = true;

    _drawNextCard();
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 1) {
        _remainingSeconds--;
        if (_remainingSeconds <= 5) {
          _soundService.playTimerWarning();
        }
        notifyListeners();
      } else {
        _remainingSeconds = 0;
        endTurn();
      }
    });
  }

  void onCorrect() {
    if (!_isTurnActive) return;
    _turnCorrect++;
    final player = currentDescriber;
    if (player != null) {
      player.correctCount++;
    }
    _soundService.playCorrect();
    _drawNextCard();
    notifyListeners();
  }

  void onHush() {
    if (!_isTurnActive) return;
    _turnHush++;
    final player = currentDescriber;
    if (player != null) {
      player.hushCount++;
    }
    _soundService.playHush();
    _drawNextCard();
    notifyListeners();
  }

  void onPass() {
    if (!_isTurnActive || !canPass) return;
    _turnPass++;
    if (!_settings.isUnlimitedPass) {
      _remainingPasses--;
    }
    final player = currentDescriber;
    if (player != null) {
      player.passCount++;
    }
    _soundService.playPass();
    _drawNextCard();
    notifyListeners();
  }

  void endTurn() {
    _timer?.cancel();
    _isTurnActive = false;
    _soundService.playTimeUp();

    final team = currentTeam;
    if (team != null && team.players.isNotEmpty) {
      final currentIdx = _teamPlayerIndices[team.id] ?? 0;
      _teamPlayerIndices[team.id] = (currentIdx + 1) % team.players.length;
    }

    if (_currentTeamIndex + 1 < _teams.length) {
      _currentTeamIndex++;
    } else {
      _currentTeamIndex = 0;
      if (_currentRound < _settings.numberOfRounds) {
        _currentRound++;
      } else {
        _isGameFinished = true;
      }
    }

    notifyListeners();
  }

  GameStats calculateGameStats() {
    return GameStats.fromTeams(_teams);
  }

  void rematch({bool retainRules = true}) {
    _timer?.cancel();
    for (var team in _teams) {
      team.resetScores();
    }
    _currentRound = 1;
    _currentTeamIndex = 0;
    _isGameFinished = false;
    _isTurnActive = false;
    _initPlayerIndices();
    _drawPile = List.from(_allCards)..shuffle();
    _currentCard = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
