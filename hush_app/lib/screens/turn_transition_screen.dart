import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'gameplay_screen.dart';

class TurnTransitionScreen extends StatelessWidget {
  const TurnTransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final team = provider.currentTeam;
    final player = provider.currentDescriber;
    final teamColor = team?.color ?? const Color(0xFF00A8FF);

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
                // Top round badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A222D),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF2C394B)),
                  ),
                  child: Text(
                    'TUR ${provider.currentRound} / ${provider.settings.numberOfRounds}',
                    style: const TextStyle(
                      color: Color(0xFFFFC048),
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                // Center Info Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A222D),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: teamColor.withOpacity(0.6), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: teamColor.withOpacity(0.18),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: teamColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          team?.name ?? 'Takım',
                          style: TextStyle(
                            color: teamColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: teamColor.withOpacity(0.2),
                        child: Icon(Icons.record_voice_over, color: teamColor, size: 48),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'ANLATACAK OYUNCU',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        player?.name ?? 'Oyuncu',
                        style: const TextStyle(
                          color: Color(0xFFF8FAFC),
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121820),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF2C394B)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone_android, color: Color(0xFF00A8FF), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Cihazı ${player?.name ?? "oyuncuya"} verin',
                              style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Start Turn Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      SoundService().playClick();
                      provider.startTurn();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const GameplayScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: teamColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 6,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 28, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'SÜREYİ BAŞLAT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
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
}
