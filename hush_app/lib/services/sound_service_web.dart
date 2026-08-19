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
          window.playHushTone = function(freq, type, duration, delay) {
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
                gain.gain.setValueAtTime(0.15, window.hushAudioCtx.currentTime);
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

  void _playTone(double freq, String type, double duration, [double delay = 0]) {
    if (!isSoundEnabled) return;
    try {
      js.context.callMethod('playHushTone', [freq, type, duration, delay]);
    } catch (e) {
      // Ignore
    }
  }

  @override
  void playClick() {
    _playTone(550, 'sine', 0.06);
  }

  @override
  void playCorrect() {
    // Beautiful double chime (C6 -> G6)
    _playTone(1046.5, 'sine', 0.12, 0.0);
    _playTone(1568.0, 'sine', 0.28, 0.08);
  }

  @override
  void playHush() {
    // Low buzzer warning (Sawtooth wave)
    _playTone(160, 'sawtooth', 0.2, 0.0);
    _playTone(140, 'sawtooth', 0.25, 0.06);
  }

  @override
  void playPass() {
    // Whoosh pitch slide (440 -> 330)
    _playTone(440, 'sine', 0.08, 0.0);
    _playTone(330, 'sine', 0.1, 0.04);
  }

  @override
  void playTimerWarning() {
    _playTone(800, 'sine', 0.05);
  }

  @override
  void playTimeUp() {
    // Low gong
    _playTone(200, 'triangle', 0.4, 0.0);
    _playTone(170, 'sawtooth', 0.5, 0.1);
  }

  @override
  void playFanfare() {
    _playTone(523.25, 'sine', 0.12, 0.0);
    _playTone(659.25, 'sine', 0.12, 0.1);
    _playTone(783.99, 'sine', 0.12, 0.2);
    _playTone(1046.50, 'sine', 0.35, 0.3);
  }
}
