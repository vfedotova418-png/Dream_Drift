import 'package:flutter/material.dart';
import 'dart:math';
import '../models/scene_theme.dart';
import 'dream_painter.dart';

class DreamScene extends StatefulWidget {
  final SceneTheme theme;

  const DreamScene({
    super.key,
    required this.theme,
  });

  @override
  State<DreamScene> createState() =>
      _DreamSceneState();
}

class _DreamSceneState extends State<DreamScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<JellyfishData> _jellyfish = [];
  List<StarData> _stars = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    _generateCreatures();
  }

  void _generateCreatures() {
    final random = Random(42);
    _jellyfish = [];
    _stars = [];

    for (int i = 0; i < 6; i++) {
      _jellyfish.add(
        JellyfishData(
          baseX: 0.15 + random.nextDouble() * 0.7,
          baseY: 0.2 + random.nextDouble() * 0.6,
          amplitudeX:
              0.04 + random.nextDouble() * 0.08,
          amplitudeY:
              0.03 + random.nextDouble() * 0.05,
          phase: random.nextDouble() * 2 * pi,
          size: 35 + random.nextDouble() * 55,
        ),
      );
    }

    for (int i = 0; i < 80; i++) {
      _stars.add(
        StarData(
          x: random.nextDouble(),
          y: random.nextDouble(),
          radius: 0.8 + random.nextDouble() * 2.2,
          twinklePhase:
              random.nextDouble() * 2 * pi,
          twinkleSpeed:
              0.2 + random.nextDouble() * 1.5,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(
    covariant DreamScene oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      _generateCreatures();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: DreamPainter(
            animationValue: _controller.value,
            jellyfish: _jellyfish,
            stars: _stars,
            theme: widget.theme,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
