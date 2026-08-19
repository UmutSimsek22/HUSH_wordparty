// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'sound_service_base.dart';

class SoundServiceImpl implements SoundServiceBase {
  @override
  bool isSoundEnabled = true;
  @override
  bool isVibrationEnabled = true;

  SoundServiceImpl() {
    _initWebAudio();
  }

  void _initWebAudio() {
    try {
      html.document.head?.append(html.ScriptElement()
        ..text = '''
          window.hushAudioCtx = window.hushAudioCtx || new (window.AudioContext || window.webkitAudioContext)();
          window.playHushTone = function(freq, type, duration, volume, delay) {
            if (!window.hushAudioCtx) return;
            if (window.hushAudioCtx.state === 'suspended') {
              window.hushAudioCtx.resume();
            }
            setTimeout(function() {
              try {
                var osc = window.hushAudioCtx.createOscillator();
                var gain = window.hushAudioCtx.createGain();
                osc.type = type || 'sine';
                osc.frequency.setValueAtTime(freq, window.hushAudioCtx.currentTime);
                var v = volume || 0.06;
                gain.gain.setValueAtTime(v, window.hushAudioCtx.currentTime);
                gain.gain.exponentialRampToValueAtTime(0.0001, window.hushAudioCtx.currentTime + duration);
                osc.connect(gain);
                gain.connect(window.hushAudioCtx.destination);
                osc.start();
                osc.stop(window.hushAudioCtx.currentTime + duration);
              } catch(e) {}
            }, (delay || 0) * 1000);
          };
        ''');
    } catch (e) {
      // Ignore
    }
  }

  void _playTone(double freq, String type, double duration, [double volume = 0.06, double delay = 0]) {
    if (!isSoundEnabled) return;
    try {
      js.context.callMethod('playHushTone', [freq, type, duration, volume, delay]);
    } catch (e) {
      // Ignore
    }
  }

  void _playSoundAsset(String fileName) {
    if (!isSoundEnabled) return;
    try {
      final audio = html.AudioElement('assets/sounds/$fileName');
      audio.volume = 0.6;
      audio.play().catchError((e) {
        // Fallback tone if asset fails
      });
    } catch (e) {
      // Ignore
    }
  }

  @override
  void playClick() {
    // Soft, crisp, pleasant pop tone (zero harsh bass)
    _playTone(650, 'sine', 0.04, 0.05);
  }

  @override
  void playCorrect() {
    _playSoundAsset('correct.wav');
  }

  @override
  void playHush() {
    _playSoundAsset('hush.wav');
  }

  @override
  void playPass() {
    _playSoundAsset('pass.wav');
  }

  @override
  void playTimerWarning() {
    // Gentle tick
    _playTone(850, 'sine', 0.04, 0.04);
  }

  @override
  void playTimeUp() {
    // Soft, pleasant warm chime (C5 -> E5 -> G5 chord)
    _playTone(523.25, 'sine', 0.3, 0.06, 0.0);
    _playTone(659.25, 'sine', 0.3, 0.06, 0.06);
    _playTone(783.99, 'sine', 0.4, 0.06, 0.12);
  }

  @override
  void playFanfare() {
    _playSoundAsset('fanfare.wav');
  }
}
