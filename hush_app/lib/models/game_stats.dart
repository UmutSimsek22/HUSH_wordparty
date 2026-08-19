import 'team.dart';
import 'player.dart';

class GameStats {
  final Team winningTeam;
  final List<Team> rankedTeams;
  final Player? mvpPlayer;
  final Player? worstPlayer;
  final List<Player> allPlayersRanked;

  GameStats({
    required this.winningTeam,
    required this.rankedTeams,
    required this.mvpPlayer,
    required this.worstPlayer,
    required this.allPlayersRanked,
  });

  factory GameStats.fromTeams(List<Team> teams) {
    final sortedTeams = List<Team>.from(teams)
      ..sort((a, b) => b.totalScore.compareTo(a.totalScore));

    final allPlayers = teams.expand((t) => t.players).toList();
    
    // Sort players by netPoints descending
    allPlayers.sort((a, b) {
      final scoreCompare = b.netPoints.compareTo(a.netPoints);
      if (scoreCompare != 0) return scoreCompare;
      return b.accuracyRate.compareTo(a.accuracyRate);
    });

    final mvp = allPlayers.isNotEmpty ? allPlayers.first : null;
    final worst = allPlayers.isNotEmpty ? allPlayers.last : null;

    return GameStats(
      winningTeam: sortedTeams.first,
      rankedTeams: sortedTeams,
      mvpPlayer: mvp,
      worstPlayer: worst,
      allPlayersRanked: allPlayers,
    );
  }
}
