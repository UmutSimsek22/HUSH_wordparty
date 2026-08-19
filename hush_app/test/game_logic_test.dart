import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hush_party/models/player.dart';
import 'package:hush_party/models/team.dart';
import 'package:hush_party/models/game_stats.dart';

void main() {
  group('Player & Team Calculations Test', () {
    test('Player accuracy and net points calculated accurately', () {
      final player = Player(id: 'p1', name: 'Ahmet', teamId: 't1');
      player.correctCount = 5;
      player.hushCount = 2;
      player.passCount = 3;

      expect(player.netPoints, 3); // 5 - 2 = 3
      expect(player.totalAttempts, 10); // 5 + 2 + 3 = 10
      expect(player.accuracyRate, 50.0); // (5 / 10) * 100 = 50%
    });

    test('Team total scores aggregate properly across multiple players', () {
      final p1 = Player(id: 'p1', name: 'Ali', teamId: 't1', correctCount: 4, hushCount: 1);
      final p2 = Player(id: 'p2', name: 'Veli', teamId: 't1', correctCount: 3, hushCount: 0);

      final team = Team(
        id: 't1',
        name: 'Kırmızı',
        color: Colors.red,
        players: [p1, p2],
      );

      expect(team.totalScore, 6); // (4-1) + (3-0) = 3 + 3 = 6
      expect(team.totalCorrect, 7);
      expect(team.totalHush, 1);
    });

    test('GameStats identifies winning team, MVP, and lowest scorer', () {
      final p1 = Player(id: 'p1', name: 'Star Player', teamId: 't1', correctCount: 10, hushCount: 0);
      final p2 = Player(id: 'p2', name: 'Average Player', teamId: 't1', correctCount: 2, hushCount: 1);
      final t1 = Team(id: 't1', name: 'Takım 1', color: Colors.red, players: [p1, p2]);

      final p3 = Player(id: 'p3', name: 'Unlucky Player', teamId: 't2', correctCount: 1, hushCount: 5);
      final t2 = Team(id: 't2', name: 'Takım 2', color: Colors.blue, players: [p3]);

      final stats = GameStats.fromTeams([t1, t2]);

      expect(stats.winningTeam.id, 't1');
      expect(stats.mvpPlayer?.name, 'Star Player');
      expect(stats.worstPlayer?.name, 'Unlucky Player');
      expect(stats.rankedTeams.first.totalScore, 11);
    });
  });
}
