import 'package:flutter/material.dart';

class CircularTimerWidget extends StatelessWidget {
  final int remainingSeconds;
  final int totalSeconds;

  const CircularTimerWidget({
    super.key,
    required this.remainingSeconds,
    required this.totalSeconds,
  });

  Color _getTimerColor() {
    final ratio = remainingSeconds / (totalSeconds > 0 ? totalSeconds : 60);
    if (ratio > 0.35) return const Color(0xFFFFC048); // Bright Gold
    if (ratio > 0.15) return const Color(0xFFFF793F); // Warm Amber
    return const Color(0xFFFF4D4D); // Flame Red
  }

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds > 0 ? (remainingSeconds / totalSeconds) : 0.0;
    final color = _getTimerColor();

    return SizedBox(
      width: 86,
      height: 86,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 7,
            backgroundColor: const Color(0xFF25303F),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$remainingSeconds',
                style: TextStyle(
                  color: color,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'SN',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
