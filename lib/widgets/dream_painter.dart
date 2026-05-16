import 'dart:math';
import 'package:flutter/material.dart';
import '../models/scene_theme.dart';

class JellyfishData {
  final double baseX;
  final double baseY;
  final double amplitudeX;
  final double amplitudeY;
  final double phase;
  final double size;

  JellyfishData({
    required this.baseX,
    required this.baseY,
    required this.amplitudeX,
    required this.amplitudeY,
    required this.phase,
    required this.size,
  });
}

class StarData {
  final double x;
  final double y;
  final double radius;
  final double twinklePhase;
  final double twinkleSpeed;

  StarData({
    required this.x,
    required this.y,
    required this.radius,
    required this.twinklePhase,
    required this.twinkleSpeed,
  });
}

class DreamPainter extends CustomPainter {
  final double animationValue;
  final List<JellyfishData> jellyfish;
  final List<StarData> stars;
  final SceneTheme theme;

  DreamPainter({
    required this.animationValue,
    required this.jellyfish,
    required this.stars,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawStars(canvas, size);
    for (final jelly in jellyfish) {
      _drawJellyfish(canvas, size, jelly);
    }
  }

  void _drawBackground(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: theme.backgroundColors,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradient.createShader(rect),
    );
  }

  void _drawStars(Canvas canvas, Size size) {
    for (final star in stars) {
      final t =
          animationValue *
              2 *
              pi *
              star.twinkleSpeed +
          star.twinklePhase;
      final opacity =
          (0.2 + 0.8 * (0.5 + 0.5 * sin(t)))
              .clamp(0.0, 1.0);
      final paint = Paint()
        ..color = Colors.white.withOpacity(
          opacity,
        )
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          1.2,
        );
      final center = Offset(
        star.x * size.width,
        star.y * size.height,
      );
      canvas.drawCircle(
        center,
        star.radius * 2.5,
        paint,
      );

      if (opacity > 0.7) {
        final glowPaint = Paint()
          ..color = theme.glowColor.withOpacity(
            opacity * 0.4,
          )
          ..maskFilter = const MaskFilter.blur(
            BlurStyle.normal,
            4,
          );
        canvas.drawCircle(
          center,
          star.radius * 2.5,
          glowPaint,
        );
      }
    }
  }

  void _drawJellyfish(
    Canvas canvas,
    Size size,
    JellyfishData jelly,
  ) {
    final time = animationValue * 2 * pi;
    final offsetX =
        jelly.amplitudeX *
        sin(time + jelly.phase) *
        size.width;
    final offsetY =
        jelly.amplitudeY *
        cos(time * 1.3 + jelly.phase) *
        size.height;
    final center = Offset(
      jelly.baseX * size.width + offsetX,
      jelly.baseY * size.height + offsetY,
    );

    final s = jelly.size;
    final domeRadius = s * 0.4;

    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              theme.glowColor.withOpacity(0.4),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: center,
              radius: domeRadius * 1.8,
            ),
          );
    canvas.drawCircle(
      center,
      domeRadius * 1.8,
      glowPaint,
    );

    final domeRect = Rect.fromCircle(
      center: Offset(
        center.dx,
        center.dy - s * 0.08,
      ),
      radius: domeRadius,
    );
    final bodyPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.75),
          theme.jellyfishBodyColor.withOpacity(
            0.55,
          ),
          Colors.transparent,
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(domeRect);
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: domeRadius,
      ),
      pi,
      pi,
      true,
      bodyPaint,
    );

    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2,
      );
    canvas.drawCircle(
      Offset(
        center.dx - domeRadius * 0.25,
        center.dy - domeRadius * 0.15,
      ),
      domeRadius * 0.12,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(
        center.dx + domeRadius * 0.2,
        center.dy - domeRadius * 0.1,
      ),
      domeRadius * 0.08,
      dotPaint,
    );

    final tentaclePaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 5; i++) {
      final angle =
          -pi * 0.75 + (i / 4) * pi * 1.5;
      final startX =
          center.dx + domeRadius * cos(angle);
      final startY =
          center.dy + domeRadius * sin(angle);
      final path = Path()..moveTo(startX, startY);

      final t = time + jelly.phase + i * 0.7;
      final wave1 = sin(t * 2.2) * 5;
      final wave2 = cos(t * 1.8) * 4;

      final seg1X =
          startX + sin(angle) * 12 + wave1;
      final seg1Y = startY + 14 + wave2;
      final seg2X =
          seg1X + sin(angle) * 10 + wave2;
      final seg2Y = seg1Y + 16 + wave1;
      final endX = seg2X + sin(angle) * 8;
      final endY = seg2Y + 12;

      path.cubicTo(
        seg1X,
        seg1Y,
        seg2X,
        seg2Y,
        endX,
        endY,
      );
      canvas.drawPath(path, tentaclePaint);

      final tipPaint = Paint()
        ..color = theme.glowColor.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          3,
        );
      canvas.drawCircle(
        Offset(endX, endY),
        2.5,
        tipPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant DreamPainter oldDelegate,
  ) =>
      oldDelegate.animationValue !=
          animationValue ||
      oldDelegate.theme != theme;
}
