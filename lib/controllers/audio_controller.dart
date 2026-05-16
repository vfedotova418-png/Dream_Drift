import 'package:audioplayers/audioplayers.dart';

class AudioController {
  final AudioPlayer _player = AudioPlayer();
  bool _isMuted = false;
  bool get isMuted => _isMuted;
  double _volume = 1.0;
  double get volume => _volume;

  Future<void> init() async {
    await _player.setSource(
      AssetSource('audio/dream.mp3'),
    );
    await _player.setReleaseMode(
      ReleaseMode.loop,
    );
    await _player.setVolume(_volume);
    _player.resume();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    _player.setVolume(_isMuted ? 0.0 : _volume);
  }

  void setVolume(double vol) {
    _volume = vol;
    if (!_isMuted) {
      _player.setVolume(_volume);
    }
  }

  void dispose() {
    _player.dispose();
  }
}
