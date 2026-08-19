import 'dart:async';
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
  // Stages:
  // 0: "OYUN BİTTİ!" suspense (drumroll sound)
  // 1: Winning Team reveal (fanfare sound)
  // 2: MVP reveal with Crown 👑 (fanfare/applause)
  // 3: Full statistics matrix & Rematch
  int _currentStage = 0;
  Timer? _stageTimer;

  @override
  void initState() {
    super.initState();
    _startStageSequence();
  }

  void _startStageSequence() {
    // Stage 0: Drumroll / Suspense
    SoundService().playTimeUp();

    _stageTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _currentStage = 1;
        });
        SoundService().playFanfare();

        _stageTimer = Timer(const Duration(milliseconds: 2500), () {
          if (mounted) {
            setState(() {
              _currentStage = 2;
            });
            SoundService().playFanfare();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _stageTimer?.cancel();
    super.dispose();
  }

  void _advanceToStats() {
    SoundService().playClick();
    setState(() {
      _currentStage = 3;
    });
  }

  void _showRematchDialog(BuildContext context, GameProvider provider) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
        ),
        title: const Row(
          children: [
            Icon(Icons.replay, color: Colors.white),
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
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Aynı Kurallarla Başla', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
    final mvp = stats.mvpPlayer;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: SafeArea(
          child: _buildStageContent(context, provider, stats, winner, mvp),
        ),
      ),
    );
  }

  Widget _buildStageContent(
    BuildContext context,
    GameProvider provider,
    GameStats stats,
    Team winner,
    Player? mvp,
  ) {
    // Stage 0: OYUN BİTTİ! suspense
    if (_currentStage == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.stars, size: 80, color: Color(0xFFFFC048)),
            const SizedBox(height: 20),
            const Text(
              'OYUN BİTTİ!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 16),
            const Text(
              'Sonuçlar Hesaplanıyor...',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
            ),
          ],
        ),
      );
    }

    // Stage 1: Champion Team Reveal
    if (_currentStage == 1) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉 🎊 🎈', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 16),
              const Text(
                'ŞAMPİYON TAKIM',
                style: TextStyle(
                  color: Color(0xFFFFC048),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: winner.color, width: 3.5),
                  boxShadow: [
                    BoxShadow(color: winner.color.withOpacity(0.3), blurRadius: 20, spreadRadius: 2),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      winner.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: winner.color,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Toplam Puan: ${winner.totalScore}',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Stage 2: MVP Reveal (Crown over name)
    if (_currentStage == 2) {
      return GestureDetector(
        onTap: _advanceToStats,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎉 🏆 🎈', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 16),
                const Text(
                  'EN İYİ OYUNCU (MVP)',
                  style: TextStyle(
                    color: Color(0xFFFFC048),
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 20),
                if (mvp != null) ...[
                  // Crown symbol above name
                  const Text('👑', style: TextStyle(fontSize: 54)),
                  const SizedBox(height: 4),
                  Text(
                    mvp.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Net Puan: +${mvp.netPoints} • Doğruluk: %${mvp.accuracyRate.toStringAsFixed(0)}',
                    style: const TextStyle(color: Color(0xFFFFC048), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white38),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'İstatistikleri Görmek İçin Tıklayın',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.touch_app, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Stage 3: Full Stats & Matrix Table
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color(0xFF1E1E1E),
          elevation: 0,
          title: const Text(
            'HUSH! • OYUN SONU & İSTATİSTİKLER',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildWinnerCard(winner),
              const SizedBox(height: 16),
              if (mvp != null) ...[
                _buildMvpCrownCard(mvp),
                const SizedBox(height: 20),
              ],
              _buildSectionTitle('🏆 TAKIM SIRALAMASI'),
              const SizedBox(height: 10),
              _buildTeamsTable(stats.rankedTeams),
              const SizedBox(height: 24),
              _buildSectionTitle('📊 TÜM OYUNCULARIN PERFORMANSI'),
              const SizedBox(height: 10),
              _buildPlayersTable(stats.allPlayersRanked, provider.teams),
            ],
          ),
        ),
        // Bottom Buttons Dock
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            border: Border(top: BorderSide(color: Color(0xFF333333))),
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
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text(
                    'ANA MENÜ',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _showRematchDialog(context, provider),
                  icon: const Icon(Icons.replay, color: Colors.black),
                  label: const Text(
                    'RÖVANŞ OYNA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
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
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFC048), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFC048).withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, color: Color(0xFFFFC048), size: 44),
          const SizedBox(height: 6),
          const Text(
            'ŞAMPİYON TAKIM',
            style: TextStyle(
              color: Color(0xFFFFC048),
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            winner.name,
            style: TextStyle(
              color: winner.color,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Toplam Puan: ${winner.totalScore}',
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMvpCrownCard(Player player) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFC048), width: 1.5),
      ),
      child: Row(
        children: [
          const Text('👑', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GÜNÜN YILDIZI (MVP)',
                  style: TextStyle(color: Color(0xFFFFC048), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1),
                ),
                Text(
                  player.name,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Text(
            'Net: +${player.netPoints}',
            style: const TextStyle(color: Color(0xFFFFC048), fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsTable(List<Team> teams) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333)),
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
                  ? const Border(bottom: BorderSide(color: Color(0xFF333333)))
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
                    fontSize: 15,
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
    return Column(
      children: players.map((player) {
        final team = teams.firstWhere(
          (t) => t.id == player.teamId,
          orElse: () => teams.first,
        );

        final netColor = player.netPoints >= 0 ? const Color(0xFF007AFF) : const Color(0xFFFF3B30);
        final netSign = player.netPoints >= 0 ? '+${player.netPoints}' : '${player.netPoints}';

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: team.color.withOpacity(0.5), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Player Name & Team Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        player.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: team.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: team.color),
                    ),
                    child: Text(
                      team.name,
                      style: TextStyle(
                        color: team.color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFF333333), height: 1),
              const SizedBox(height: 12),
              // Detailed Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatBadge('DOĞRU', '+${player.correctCount}', const Color(0xFF007AFF)),
                  _buildStatBadge('HUSH!', '-${player.hushCount}', const Color(0xFFFF3B30)),
                  _buildStatBadge('PAS', '${player.passCount}', const Color(0xFFFF793F)),
                  _buildStatBadge('İSABET', '%${player.accuracyRate.toStringAsFixed(0)}', const Color(0xFFFFC048)),
                  _buildStatBadge('NET PUAN', netSign, netColor, isBold: true),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatBadge(String label, String value, Color color, {bool isBold = false}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: isBold ? 17 : 15,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
