import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'sound_service_base.dart';

class SoundServiceImpl implements SoundServiceBase {
  @override
  bool isSoundEnabled = true;
  @override
  bool isVibrationEnabled = true;

  final AudioPlayer _player = AudioPlayer();

  void _playSound(String fileName) async {
    if (!isSoundEnabled) return;
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/$fileName'));
    } catch (e) {
      // Fallback
    }
  }

  @override
  void playClick() {
    if (isVibrationEnabled) HapticFeedback.lightImpact();
    _playSound('click.wav');
  }

  @override
  void playCorrect() {
    if (isVibrationEnabled) HapticFeedback.mediumImpact();
    _playSound('correct.wav');
  }

  @override
  void playHush() {
    if (isVibrationEnabled) HapticFeedback.heavyImpact();
    _playSound('hush.wav');
  }

  @override
  void playPass() {
    if (isVibrationEnabled) HapticFeedback.selectionClick();
    _playSound('pass.wav');
  }

  @override
  void playTimerWarning() {
    if (isVibrationEnabled) HapticFeedback.selectionClick();
    _playSound('timer.wav');
  }

  @override
  void playTimeUp() {
    if (isVibrationEnabled) HapticFeedback.vibrate();
    _playSound('timeup.wav');
  }

  @override
  void playFanfare() {
    if (isVibrationEnabled) HapticFeedback.mediumImpact();
    _playSound('fanfare.wav');
  }
}
