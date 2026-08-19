import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/circular_timer.dart';
import '../widgets/hush_card_widget.dart';
import '../widgets/action_button.dart';
import 'round_summary_screen.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    // If turn is finished, navigate to RoundSummaryScreen
    if (!provider.isTurnActive) {
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
    final teamColor = team?.color ?? const Color(0xFF00A8FF);

    final passSubtitle = provider.settings.isUnlimitedPass
        ? 'Sınırsız'
        : '${provider.remainingPasses} Hak';

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF121820),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // Top Header Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Team & Player Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: teamColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: teamColor.withOpacity(0.5)),
                            ),
                            child: Text(
                              team?.name ?? '',
                              style: TextStyle(
                                color: teamColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            player?.name ?? '',
                            style: const TextStyle(
                              color: Color(0xFFF8FAFC),
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Circular Timer
                    CircularTimerWidget(
                      remainingSeconds: provider.remainingSeconds,
                      totalSeconds: provider.settings.timePerTurnSeconds,
                    ),

                    // Turn Net Score Badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'BU TUR PUAN',
                            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: provider.turnNetPoints >= 0
                                  ? const Color(0xFF00A8FF).withOpacity(0.2)
                                  : const Color(0xFFFF4D4D).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: provider.turnNetPoints >= 0
                                    ? const Color(0xFF00A8FF)
                                    : const Color(0xFFFF4D4D),
                              ),
                            ),
                            child: Text(
                              provider.turnNetPoints >= 0 ? '+${provider.turnNetPoints}' : '${provider.turnNetPoints}',
                              style: TextStyle(
                                color: provider.turnNetPoints >= 0 ? const Color(0xFF00A8FF) : const Color(0xFFFF4D4D),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      color: const Color(0xFFFF4D4D),
                      onPressed: provider.onTaboo,
                    ),
                    const SizedBox(width: 8),

                    // DOĞRU (+1)
                    ActionGameButton(
                      title: 'DOĞRU',
                      subtitle: '+1 Puan',
                      icon: Icons.check,
                      color: const Color(0xFF00A8FF),
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
