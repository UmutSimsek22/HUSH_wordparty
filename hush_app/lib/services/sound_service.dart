import 'sound_service_base.dart';
import 'sound_service_mobile.dart'
    if (dart.library.html) 'sound_service_web.dart';

class SoundService implements SoundServiceBase {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final SoundServiceBase _delegate = SoundServiceImpl();

  @override
  bool get isSoundEnabled => _delegate.isSoundEnabled;

  @override
  set isSoundEnabled(bool value) => _delegate.isSoundEnabled = value;

  @override
  bool get isVibrationEnabled => _delegate.isVibrationEnabled;

  @override
  set isVibrationEnabled(bool value) => _delegate.isVibrationEnabled = value;

  @override
  void playClick() => _delegate.playClick();

  @override
  void playCorrect() => _delegate.playCorrect();

  @override
  void playHush() => _delegate.playHush();

  @override
  void playPass() => _delegate.playPass();

  @override
  void playTimerWarning() => _delegate.playTimerWarning();

  @override
  void playTimeUp() => _delegate.playTimeUp();

  @override
  void playFanfare() => _delegate.playFanfare();
}
