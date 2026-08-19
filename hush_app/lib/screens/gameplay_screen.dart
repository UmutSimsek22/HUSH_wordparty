import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import '../widgets/circular_timer.dart';
import '../widgets/hush_card_widget.dart';
import '../widgets/action_button.dart';
import 'round_summary_screen.dart';
import 'welcome_screen.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  void _showPauseAbandonDialog(BuildContext context, GameProvider provider) {
    provider.pauseTurn();
    SoundService().playClick();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
        ),
        title: const Row(
          children: [
            Icon(Icons.pause_circle_filled, color: Color(0xFFFFC048), size: 28),
            SizedBox(width: 10),
            Text(
              'Oyun Duraklatıldı',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text(
          'Oyunu bozmak istediğinize emin misiniz?',
          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SoundService().playClick();
              Navigator.pop(ctx);
              provider.resumeTurn();
            },
            child: const Text(
              'Devam Et',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              SoundService().playClick();
              Navigator.pop(ctx);
              provider.abandonGame();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF3B30),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Oyunu Boz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    // If turn is finished (and not paused/abandoned), navigate to RoundSummaryScreen
    if (!provider.isTurnActive && !provider.isPaused && !provider.isAbandoned) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const RoundSummaryScreen()),
          );
        }
      });
    }

    final team = provider.currentTeam;
    final player = provider.currentDescriber;
    final teamColor = team?.color ?? const Color(0xFF007AFF);

    final passSubtitle = provider.settings.isUnlimitedPass
        ? 'Sınırsız'
        : '${provider.remainingPasses} Hak';

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _showPauseAbandonDialog(context, provider);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // Top Header Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Abandon / Pause Button & Team/Player Info
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.pause_circle_outline, color: Colors.white, size: 30),
                          onPressed: () => _showPauseAbandonDialog(context, provider),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: teamColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: teamColor),
                              ),
                              child: Text(
                                team?.name ?? '',
                                style: TextStyle(
                                  color: teamColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              player?.name ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Circular Timer
                    CircularTimerWidget(
                      remainingSeconds: provider.remainingSeconds,
                      totalSeconds: provider.settings.timePerTurnSeconds,
                    ),

                    // Turn Net Score Badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'BU TUR PUAN',
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: provider.turnNetPoints >= 0
                                ? const Color(0xFF007AFF).withOpacity(0.2)
                                : const Color(0xFFFF3B30).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: provider.turnNetPoints >= 0
                                  ? const Color(0xFF007AFF)
                                  : const Color(0xFFFF3B30),
                            ),
                          ),
                          child: Text(
                            provider.turnNetPoints >= 0 ? '+${provider.turnNetPoints}' : '${provider.turnNetPoints}',
                            style: TextStyle(
                              color: provider.turnNetPoints >= 0 ? const Color(0xFF007AFF) : const Color(0xFFFF3B30),
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Center Hush Card
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: HushCardWidget(
                        card: provider.currentCard,
                        teamColor: teamColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Bottom Action Buttons Dock (Pas, HUSH!, Doğru)
                Row(
                  children: [
                    // PAS (0)
                    ActionGameButton(
                      title: 'PAS',
                      subtitle: passSubtitle,
                      icon: Icons.skip_next,
                      color: const Color(0xFFFF793F),
                      isEnabled: provider.canPass,
                      onPressed: provider.onPass,
                    ),
                    const SizedBox(width: 8),

                    // HUSH! (-1)
                    ActionGameButton(
                      title: 'HUSH!',
                      subtitle: '-1 Ceza',
                      icon: Icons.close,
                      color: const Color(0xFFFF3B30),
                      onPressed: provider.onHush,
                    ),
                    const SizedBox(width: 8),

                    // DOĞRU (+1)
                    ActionGameButton(
                      title: 'DOĞRU',
                      subtitle: '+1 Puan',
                      icon: Icons.check,
                      color: const Color(0xFF007AFF),
                      onPressed: provider.onCorrect,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
