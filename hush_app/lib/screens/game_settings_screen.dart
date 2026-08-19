import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_settings.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'turn_transition_screen.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  int _selectedDuration = 60;
  int _selectedRounds = 2;
  int? _selectedPassLimit = 3; // null means unlimited
  bool _isSoundEnabled = true;
  bool _isVibrationEnabled = true;

  final List<int> _durationOptions = [30, 45, 60, 90, 120];
  final List<int> _roundOptions = [1, 2, 3, 4, 5];
  final List<int?> _passOptions = [1, 2, 3, 5, null]; // null is Sınırsız

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GameProvider>(context, listen: false);
    _selectedDuration = provider.settings.timePerTurnSeconds;
    _selectedRounds = provider.settings.numberOfRounds;
    _selectedPassLimit = provider.settings.passLimit;
    _isSoundEnabled = provider.settings.isSoundEnabled;
    _isVibrationEnabled = provider.settings.isVibrationEnabled;
  }

  void _onStartGame() {
    SoundService().playClick();
    final provider = Provider.of<GameProvider>(context, listen: false);
    provider.updateSettings(
      GameSettings(
        timePerTurnSeconds: _selectedDuration,
        numberOfRounds: _selectedRounds,
        passLimit: _selectedPassLimit,
        isSoundEnabled: _isSoundEnabled,
        isVibrationEnabled: _isVibrationEnabled,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TurnTransitionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121820),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A222D),
        elevation: 0,
        title: const Text(
          'OYUN KURALLARI',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // 1. Anlatma Seansı Süresi
                  _buildSectionHeader(Icons.timer, 'BİR ANLATMA SEANSI SÜRESİ'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _durationOptions.map((sec) {
                      final isSelected = _selectedDuration == sec;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            SoundService().playClick();
                            setState(() => _selectedDuration = sec);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF00A8FF) : const Color(0xFF1A222D),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF00A8FF) : const Color(0xFF2C394B),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              '$sec sn',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 26),

                  // 2. Oyun Kaç Tur Olacak?
                  _buildSectionHeader(Icons.repeat, 'OYUN KAÇ TUR OLACAK?'),
                  const SizedBox(height: 4),
                  const Text(
                    'Örn: 2 tur seçilirse her takım 2 kez anlatır.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _roundOptions.map((rounds) {
                      final isSelected = _selectedRounds == rounds;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            SoundService().playClick();
                            setState(() => _selectedRounds = rounds);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFFC048) : const Color(0xFF1A222D),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFFC048) : const Color(0xFF2C394B),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              '$rounds Tur',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF121820) : const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w900,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 26),

                  // 3. Pas Hakkı (Sınırsız seçeneği)
                  _buildSectionHeader(Icons.skip_next, 'TUR BAŞINA PAS HAKKI'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _passOptions.map((pass) {
                      final isSelected = _selectedPassLimit == pass;
                      final label = pass == null ? 'Sınırsız' : '$pass Pas';
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            SoundService().playClick();
                            setState(() => _selectedPassLimit = pass);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFF793F) : const Color(0xFF1A222D),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFF793F) : const Color(0xFF2C394B),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 26),

                  // 4. Ses ve Titreşim
                  _buildSectionHeader(Icons.volume_up, 'GERİ BİLDİRİM AYARLARI'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A222D),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2C394B)),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Ses Efektleri', style: TextStyle(color: Colors.white, fontSize: 14)),
                          subtitle: const Text('Doğru, HUSH! ve süre sonu tonları', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                          value: _isSoundEnabled,
                          activeColor: const Color(0xFF00A8FF),
                          onChanged: (val) {
                            SoundService().playClick();
                            setState(() => _isSoundEnabled = val);
                          },
                        ),
                        const Divider(color: Color(0xFF2C394B)),
                        SwitchListTile(
                          title: const Text('Titreşim (Haptik)', style: TextStyle(color: Colors.white, fontSize: 14)),
                          subtitle: const Text('Buton dokunma titreşimleri', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                          value: _isVibrationEnabled,
                          activeColor: const Color(0xFF00A8FF),
                          onChanged: (val) {
                            SoundService().playClick();
                            setState(() => _isVibrationEnabled = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1A222D),
                border: Border(top: BorderSide(color: Color(0xFF2C394B))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _onStartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A8FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                  child: const Text(
                    'OYUNU BAŞLAT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00A8FF), size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFF8FAFC),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
