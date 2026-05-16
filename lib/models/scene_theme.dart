import 'package:flutter/material.dart';

enum SceneTheme {
  oceanSpace,
  sunsetDeep,
  auroraForest,
}

extension SceneThemeExtension on SceneTheme {
  String get label {
    switch (this) {
      case SceneTheme.oceanSpace:
        return 'Ocean Space';
      case SceneTheme.sunsetDeep:
        return 'Sunset Deep';
      case SceneTheme.auroraForest:
        return 'Aurora Forest';
    }
  }

  IconData get icon {
    switch (this) {
      case SceneTheme.oceanSpace:
        return Icons.water;
      case SceneTheme.sunsetDeep:
        return Icons.wb_twighlight;
      case SceneTheme.auroraForest:
        return Icons.forest;
    }
  }

  List<Color> get backgroundColors {
    switch (this) {
      case SceneTheme.oceanSpace:
        return const [
          Color(0xFF0A0E27),
          Color(0xFF111B3D),
          Color(0xFF0F3460),
          Color(0xFF0A1628),
        ];
      case SceneTheme.sunsetDeep:
        return const [
          Color(0xFF1A0A2E),
          Color(0xFF3D1538),
          Color(0xFF6B2C3E),
          Color(0xFF1C0F1A),
        ];
      case SceneTheme.auroraForest:
        return const [
          Color(0xFF0A1A0F),
          Color(0xFF0F2B1D),
          Color(0xFF1A4A3A),
          Color(0xFF0C1F14),
        ];
    }
  }

  Color get glowColor {
    switch (this) {
      case SceneTheme.oceanSpace:
        return const Color(0x88AEEEEE);
      case SceneTheme.sunsetDeep:
        return const Color(0x88FFB6C1);
      case SceneTheme.auroraForest:
        return const Color(0x88A8E6CF);
    }
  }

  Color get jellyfishBodyColor {
    switch (this) {
      case SceneTheme.oceanSpace:
        return const Color(0x557BC8E8);
      case SceneTheme.sunsetDeep:
        return const Color(0x55FF8FAB);
      case SceneTheme.auroraForest:
        return const Color(0x5588D8B0);
    }
  }
}
