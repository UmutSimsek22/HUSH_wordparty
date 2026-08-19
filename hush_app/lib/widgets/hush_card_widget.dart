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
          color: const Color(0xFFF4F1EA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
      );
    }

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 380),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F1EA), // Vintage Off-white / Cream
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black,
          width: 3.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(4, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Target Word Header (Vintage Press Header Style)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: teamColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: const Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
              ),
            ),
            child: Text(
              card!.targetWord.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontFamily: 'Courier',
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1.5, 1.5),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Forbidden / Yasaklı badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.block, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  'YASAKLI KELİMELER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Forbidden Words List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: card!.forbiddenWords.map((word) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black87,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    word,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontFamily: 'Courier',
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
