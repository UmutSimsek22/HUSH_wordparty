import 'package:flutter/material.dart';
import '../models/hush_card.dart';

class HushCardWidget extends StatelessWidget {
  final HushCard? card;
  final Color teamColor;

  const HushCardWidget({
    super.key,
    required this.card,
    required this.teamColor,
  });

  @override
  Widget build(BuildContext context) {
    if (card == null) {
      return Container(
        height: 380,
        decoration: BoxDecoration(
          color: const Color(0xFF1A222D),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF2C394B), width: 2),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF00A8FF)),
        ),
      );
    }

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 380),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: teamColor.withOpacity(0.6),
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: teamColor.withOpacity(0.15),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Target Word Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: teamColor.withOpacity(0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
              ),
              border: Border(
                bottom: BorderSide(
                  color: teamColor.withOpacity(0.4),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              card!.targetWord,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFF8FAFC),
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: teamColor.withOpacity(0.8),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Forbidden / Yasaklı badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF4D4D).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFF4D4D).withOpacity(0.4)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.block, color: Color(0xFFFF4D4D), size: 16),
                SizedBox(width: 6),
                Text(
                  'YASAKLI KELİMELER',
                  style: TextStyle(
                    color: Color(0xFFFF4D4D),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Forbidden Words List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: card!.forbiddenWords.map((word) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121820),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF2C394B),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    word,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
