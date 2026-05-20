import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/audio_controller.dart';
import '../models/scene_theme.dart';
import '../widgets/dream_scene.dart';
import '../widgets/mute_button.dart';
import '../widgets/settings_sheet.dart';

class DreamScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const DreamScreen({
    super.key,
    required this.prefs,
  });

  @override
  State<DreamScreen> createState() =>
      _DreamScreenState();
}

class _DreamScreenState
    extends State<DreamScreen> {
  final AudioController _audioController =
      AudioController();
  bool _isMuted = false;
  double _volume = 1.0;
  SceneTheme _currentTheme =
      SceneTheme.oceanSpace;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _audioController.init();
  }

  Future<void> _loadPreferences() async {
    final prefs = widget.prefs;
    setState(() {
      _isMuted =
          prefs.getBool('isMuted') ?? false;
      _volume = prefs.getDouble('volume') ?? 1.0;
      final themeIndex =
          prefs.getInt('theme') ?? 0;
      _currentTheme =
          SceneTheme.values[themeIndex];
      _audioController.setVolume(_volume);
      if (_isMuted) _audioController.toggleMute();
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _audioController.toggleMute();
      widget.prefs.setBool('isMuted', _isMuted);
    });
  }

  void _setVolume(double vol) {
    setState(() {
      _volume = vol;
      _audioController.setVolume(_volume);
      widget.prefs.setDouble('volume', _volume);
    });
  }

  void _setTheme(SceneTheme theme) {
    setState(() {
      _currentTheme = theme;
      widget.prefs.setInt(
        'theme',
        SceneTheme.values.indexOf(theme),
      );
    });
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SettingsSheet(
        currentTheme: _currentTheme,
        volume: _volume,
        isMuted: _isMuted,
        onVolumeChanged: _setVolume,
        onThemeChanged: (theme) {
          _setTheme(theme);
        },
      ),
    );
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DreamScene(
              theme: _currentTheme,
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: _goBack,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white.withOpacity(
                    0.7,
                  ),
                  size: 22,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: _showSettings,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings_rounded,
                  color: Colors.white.withOpacity(
                    0.7,
                  ),
                  size: 22,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 30,
            child: MuteButton(
              isMuted: _isMuted,
              onToggle: _toggleMute,
              glowColor: _currentTheme.glowColor,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            child: GestureDetector(
              onTap: _showSettings,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 500,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _currentTheme.glowColor
                      .withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _currentTheme.glowColor
                        .withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  _currentTheme.icon,
                  color: _currentTheme.glowColor
                      .withOpacity(0.8),
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'dream drift',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(0.7),
                    fontSize: 18,
                    letterSpacing: 6,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  child: Text(
                    _currentTheme.label,
                    key: ValueKey(_currentTheme),
                    style: TextStyle(
                      color: _currentTheme
                          .glowColor
                          .withOpacity(0.5),
                      fontSize: 10,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
