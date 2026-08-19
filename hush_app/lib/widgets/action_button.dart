import 'package:flutter/material.dart';

class ActionGameButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const ActionGameButton({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isEnabled ? color : const Color(0xFF475569);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(16),
          splashColor: effectiveColor.withOpacity(0.3),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: effectiveColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: effectiveColor.withOpacity(isEnabled ? 0.7 : 0.3),
                width: 2,
              ),
              boxShadow: isEnabled
                  ? [
                      BoxShadow(
                        color: effectiveColor.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: effectiveColor, size: 28),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: isEnabled ? const Color(0xFFF8FAFC) : const Color(0xFF94A3B8),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: effectiveColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
