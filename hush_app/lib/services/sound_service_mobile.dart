import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'sound_service_base.dart';

class SoundServiceImpl implements SoundServiceBase {
  @override
  bool isSoundEnabled = true;
  @override
  bool isVibrationEnabled = true;

  void _playSound(String fileName) async {
    if (!isSoundEnabled) return;
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('sounds/$fileName'));
      player.onPlayerComplete.listen((_) {
        player.dispose();
      });
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
    if (isVibrationEnabled) HapticFeedback.mediumImpact();
    _playSound('timeup.wav');
  }

  @override
  void playFanfare() {
    if (isVibrationEnabled) HapticFeedback.mediumImpact();
    _playSound('fanfare.wav');
  }
}
