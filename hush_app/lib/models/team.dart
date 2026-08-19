import 'package:flutter/material.dart';
import 'player.dart';

class Team {
  final String id;
  String name;
  Color color;
  List<Player> players;

  Team({
    required this.id,
    required this.name,
    required this.color,
    required this.players,
  });

  int get totalScore {
    return players.fold(0, (sum, player) => sum + player.netPoints);
  }

  int get totalCorrect {
    return players.fold(0, (sum, player) => sum + player.correctCount);
  }

  int get totalTaboo {
    return players.fold(0, (sum, player) => sum + player.tabooCount);
  }

  int get totalPass {
    return players.fold(0, (sum, player) => sum + player.passCount);
  }

  void resetScores() {
    for (var player in players) {
      player.resetScore();
    }
  }
}
