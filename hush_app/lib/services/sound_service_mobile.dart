import 'package:flutter/services.dart';
import 'sound_service_base.dart';

class SoundServiceImpl implements SoundServiceBase {
  @override
  bool isSoundEnabled = true;
  @override
  bool isVibrationEnabled = true;

  @override
  void playClick() {
    if (isVibrationEnabled) HapticFeedback.lightImpact();
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playCorrect() {
    if (isVibrationEnabled) HapticFeedback.mediumImpact();
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playHush() {
    if (isVibrationEnabled) HapticFeedback.heavyImpact();
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.alert);
  }

  @override
  void playPass() {
    if (isVibrationEnabled) HapticFeedback.selectionClick();
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playTimerWarning() {
    if (isVibrationEnabled) HapticFeedback.selectionClick();
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playTimeUp() {
    if (isVibrationEnabled) HapticFeedback.vibrate();
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.alert);
  }

  @override
  void playFanfare() {
    if (!isSoundEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }
}
