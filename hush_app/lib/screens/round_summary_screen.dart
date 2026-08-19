import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'turn_transition_screen.dart';
import 'game_over_screen.dart';

class RoundSummaryScreen extends StatelessWidget {
  const RoundSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final isGameOver = provider.isGameFinished;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF121820),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Column(
                  children: [
                    const Icon(Icons.alarm_off, color: Color(0xFFFF4D4D), size: 54),
                    const SizedBox(height: 12),
                    const Text(
                      'SÜRE BİTTİ!',
                      style: TextStyle(
                        color: Color(0xFFFF4D4D),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Seans Tamamlandı',
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                    ),
                  ],
                ),

                // Performance Summary Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A222D),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF2C394B), width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'BU SEANSTA KAZANILAN PUAN',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        provider.turnNetPoints >= 0
                            ? '+${provider.turnNetPoints}'
                            : '${provider.turnNetPoints}',
                        style: TextStyle(
                          color: provider.turnNetPoints >= 0
                              ? const Color(0xFF00A8FF)
                              : const Color(0xFFFF4D4D),
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Color(0xFF2C394B)),
                      const SizedBox(height: 16),

                      // Breakdown Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Doğru', '+${provider.turnCorrect}', const Color(0xFF00A8FF), Icons.check_circle),
                          _buildStatItem('HUSH!', '-${provider.turnHush}', const Color(0xFFFF4D4D), Icons.cancel),
                          _buildStatItem('Pas', '${provider.turnPass}', const Color(0xFFFF793F), Icons.skip_next),
                        ],
                      ),
                    ],
                  ),
                ),

                // Next Action Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      SoundService().playClick();
                      if (isGameOver) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const GameOverScreen()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const TurnTransitionScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGameOver ? const Color(0xFFFFC048) : const Color(0xFF00A8FF),
                      foregroundColor: isGameOver ? const Color(0xFF121820) : Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isGameOver ? 'OYUN SONU & İSTATİSTİKLER' : 'SIRADAKİ TAKIMA GEÇ',
                          style: TextStyle(
                            color: isGameOver ? const Color(0xFF121820) : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: isGameOver ? const Color(0xFF121820) : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
