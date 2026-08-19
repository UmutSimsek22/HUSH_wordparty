abstract class SoundServiceBase {
  bool isSoundEnabled = true;
  bool isVibrationEnabled = true;

  void playClick();
  void playCorrect();
  void playHush();
  void playPass();
  void playTimerWarning();
  void playTimeUp();
  void playFanfare();
}
