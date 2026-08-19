import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/game_stats.dart';
import '../models/player.dart';
import '../models/team.dart';
import '../services/sound_service.dart';
import 'turn_transition_screen.dart';
import 'game_settings_screen.dart';
import 'welcome_screen.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({super.key});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SoundService().playFanfare();
    });
  }

  void _showRematchDialog(BuildContext context, GameProvider provider) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A222D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF2C394B), width: 1.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.replay, color: Color(0xFF00A8FF)),
            SizedBox(width: 10),
            Text('Rövanş Maçı', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Aynı takımlarla rövanş oynanacak.\n\nÖnceki oyun kuralları (tur süresi, tur sayısı, pas hakkı) ile devam edilsin mi?',
          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SoundService().playClick();
              Navigator.pop(ctx);
              provider.rematch(retainRules: false);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const GameSettingsScreen()),
                (route) => false,
              );
            },
            child: const Text('Kuralları Değiştir', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              SoundService().playClick();
              Navigator.pop(ctx);
              provider.rematch(retainRules: true);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const TurnTransitionScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A8FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Aynı Kurallarla Başla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context, listen: false);
    final stats = provider.calculateGameStats();
    final winner = stats.winningTeam;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF121820),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A222D),
          elevation: 0,
          title: const Text(
            'HUSH! • OYUN SONU & İSTATİSTİKLER',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Winner Team Banner
                    _buildWinnerCard(winner),

                    const SizedBox(height: 20),

                    // MVP & Worst Describer Row
                    Row(
                      children: [
                        if (stats.mvpPlayer != null)
                          Expanded(
                            child: _buildAwardCard(
                              title: 'GÜNÜN YILDIZI',
                              subtitle: 'En İyi Anlatıcı',
                              player: stats.mvpPlayer!,
                              color: const Color(0xFFFFC048),
                              icon: Icons.emoji_events,
                            ),
                          ),
                        const SizedBox(width: 12),
                        if (stats.worstPlayer != null)
                          Expanded(
                            child: _buildAwardCard(
                              title: 'GÜNÜN TALİHSİZİ',
                              subtitle: 'En Düşük Puan',
                              player: stats.worstPlayer!,
                              color: const Color(0xFFFF4D4D),
                              icon: Icons.sentiment_very_dissatisfied,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Teams Leaderboard Table
                    _buildSectionTitle('🏆 TAKIM SIRALAMASI'),
                    const SizedBox(height: 10),
                    _buildTeamsTable(stats.rankedTeams),

                    const SizedBox(height: 24),

                    // Detailed Players Stats Table
                    _buildSectionTitle('📊 TÜM OYUNCULARIN PERFORMANSI'),
                    const SizedBox(height: 10),
                    _buildPlayersTable(stats.allPlayersRanked, provider.teams),
                  ],
                ),
              ),

              // Bottom Buttons Dock (Ana Menü & Rövanş)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A222D),
                  border: Border(top: BorderSide(color: Color(0xFF2C394B))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          SoundService().playClick();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.home, color: Color(0xFF94A3B8)),
                        label: const Text(
                          'ANA MENÜ',
                          style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFF2C394B)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () => _showRematchDialog(context, provider),
                        icon: const Icon(Icons.replay, color: Colors.white),
                        label: const Text(
                          'RÖVANŞ OYNA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A8FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFFF8FAFC),
        fontSize: 15,
        fontWeight: FontWeight.w900,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildWinnerCard(Team winner) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFC048), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFC048).withOpacity(0.2),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.military_tech, color: Color(0xFFFFC048), size: 48),
          const SizedBox(height: 8),
          const Text(
            'ŞAMPİYON',
            style: TextStyle(
              color: Color(0xFFFFC048),
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            winner.name,
            style: TextStyle(
              color: winner.color,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Toplam Puan: ${winner.totalScore}',
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAwardCard({
    required String title,
    required String subtitle,
    required Player player,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
          ),
          const SizedBox(height: 8),
          Text(
            player.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            'Net: ${player.netPoints >= 0 ? "+${player.netPoints}" : player.netPoints} Puan',
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsTable(List<Team> teams) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A222D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2C394B)),
      ),
      child: Column(
        children: teams.asMap().entries.map((entry) {
          final rank = entry.key + 1;
          final team = entry.value;
          final isTop = rank == 1;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: rank != teams.length
                  ? const Border(bottom: BorderSide(color: Color(0xFF2C394B)))
                  : null,
            ),
            child: Row(
              children: [
                Text(
                  rank == 1 ? '🥇' : rank == 2 ? '🥈' : rank == 3 ? '🥉' : '$rank.',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 12),
                CircleAvatar(backgroundColor: team.color, radius: 8),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    team.name,
                    style: TextStyle(
                      color: isTop ? Colors.white : const Color(0xFFCBD5E1),
                      fontSize: 15,
                      fontWeight: isTop ? FontWeight.w900 : FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${team.totalScore} Puan',
                  style: TextStyle(
                    color: team.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlayersTable(List<Player> players, List<Team> teams) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A222D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2C394B)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: const TextStyle(
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          dataTextStyle: const TextStyle(
            color: Color(0xFFF8FAFC),
            fontSize: 13,
          ),
          columns: const [
            DataColumn(label: Text('OYUNCU')),
            DataColumn(label: Text('TAKIM')),
            DataColumn(label: Text('DOĞRU')),
            DataColumn(label: Text('HUSH!')),
            DataColumn(label: Text('PAS')),
            DataColumn(label: Text('İSABET %')),
            DataColumn(label: Text('NET PUAN')),
          ],
          rows: players.map((player) {
            final team = teams.firstWhere(
              (t) => t.id == player.teamId,
              orElse: () => teams.first,
            );

            return DataRow(
              cells: [
                DataCell(Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(backgroundColor: team.color, radius: 5),
                      const SizedBox(width: 6),
                      Text(team.name, style: TextStyle(color: team.color, fontSize: 12)),
                    ],
                  ),
                ),
                DataCell(Text('+${player.correctCount}', style: const TextStyle(color: Color(0xFF00A8FF)))),
                DataCell(Text('-${player.hushCount}', style: const TextStyle(color: Color(0xFFFF4D4D)))),
                DataCell(Text('${player.passCount}', style: const TextStyle(color: Color(0xFFFF793F)))),
                DataCell(Text('%${player.accuracyRate.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFFFFC048)))),
                DataCell(
                  Text(
                    player.netPoints >= 0 ? '+${player.netPoints}' : '${player.netPoints}',
                    style: TextStyle(
                      color: player.netPoints >= 0 ? const Color(0xFF00A8FF) : const Color(0xFFFF4D4D),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
