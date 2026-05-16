import 'package:flutter/material.dart';

class MuteButton extends StatelessWidget {
  final bool isMuted;
  final VoidCallback onToggle;
  final Color glowColor;

  const MuteButton({
    super.key,
    required this.isMuted,
    required this.onToggle,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 400,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isMuted
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.18),
          shape: BoxShape.circle,
          border: Border.all(
            color: isMuted
                ? Colors.white12
                : Colors.white30,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isMuted
                  ? Colors.transparent
                  : glowColor.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          isMuted
              ? Icons.volume_off_rounded
              : Icons.volume_up_rounded,
          color: isMuted
              ? Colors.white30
              : Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
