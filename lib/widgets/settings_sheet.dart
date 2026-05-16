import 'package:flutter/material.dart';
import '../models/scene_theme.dart';

class SettingsSheet extends StatefulWidget {
  final SceneTheme currentTheme;
  final double volume;
  final bool isMuted;
  final ValueChanged<double> onVolumeChanged;
  final ValueChanged<SceneTheme> onThemeChanged;

  const SettingsSheet({
    super.key,
    required this.currentTheme,
    required this.volume,
    required this.isMuted,
    required this.onVolumeChanged,
    required this.onThemeChanged,
  });

  @override
  State<SettingsSheet> createState() =>
      _SettingsSheetState();
}

class _SettingsSheetState
    extends State<SettingsSheet> {
  late double _volume;
  late SceneTheme _selectedTheme;

  @override
  void initState() {
    super.initState();
    _volume = widget.volume;
    _selectedTheme = widget.currentTheme;
  }

  @override
  void didUpdateWidget(
    covariant SettingsSheet oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentTheme !=
        widget.currentTheme) {
      setState(() {
        _selectedTheme = widget.currentTheme;
      });
    }
    if (oldWidget.volume != widget.volume) {
      setState(() {
        _volume = widget.volume;
      });
    }
  }

  void _onThemeSelected(SceneTheme theme) {
    setState(() {
      _selectedTheme = theme;
    });
    widget.onThemeChanged(theme);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(
          0xFF0A0E27,
        ).withOpacity(0.97),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _selectedTheme.glowColor
              .withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _selectedTheme.glowColor
                .withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.2,
                ),
                borderRadius:
                    BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Center(
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white.withOpacity(
                  0.8,
                ),
                fontSize: 18,
                letterSpacing: 4,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Icon(
                widget.isMuted
                    ? Icons.volume_off_rounded
                    : Icons.volume_up_rounded,
                color: Colors.white.withOpacity(
                  0.6,
                ),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Volume',
                style: TextStyle(
                  color: Colors.white.withOpacity(
                    0.6,
                  ),
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: _selectedTheme
                  .glowColor
                  .withOpacity(0.7),
              inactiveTrackColor: Colors.white
                  .withOpacity(0.1),
              thumbColor:
                  _selectedTheme.glowColor,
              overlayColor: _selectedTheme
                  .glowColor
                  .withOpacity(0.1),
              trackHeight: 3,
            ),
            child: Slider(
              value: _volume,
              min: 0.0,
              max: 1.0,
              onChanged: (val) {
                setState(() => _volume = val);
                widget.onVolumeChanged(val);
              },
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Colour Theme',
            style: TextStyle(
              color: Colors.white.withOpacity(
                0.6,
              ),
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: SceneTheme.values.map((
              theme,
            ) {
              final isSelected =
                  theme == _selectedTheme;
              return GestureDetector(
                onTap: () =>
                    _onThemeSelected(theme),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.glowColor
                              .withOpacity(0.2)
                        : Colors.white
                              .withOpacity(0.05),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? theme.glowColor
                                .withOpacity(0.7)
                          : Colors.white
                                .withOpacity(
                                  0.15,
                                ),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: theme
                                  .glowColor
                                  .withOpacity(
                                    0.3,
                                  ),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    theme.icon,
                    color: isSelected
                        ? theme.glowColor
                        : Colors.white
                              .withOpacity(0.4),
                    size: 22,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 300,
              ),
              child: Text(
                _selectedTheme.label,
                key: ValueKey(_selectedTheme),
                style: TextStyle(
                  color: _selectedTheme.glowColor
                      .withOpacity(0.6),
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Center(
            child: Text(
              'music: [dream] by sylvia plath',
              style: TextStyle(
                color: Colors.white.withOpacity(
                  0.2,
                ),
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
