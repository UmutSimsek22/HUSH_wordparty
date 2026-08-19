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

  final List<int> _durationOptions = [10, 30, 45, 60, 90, 120];
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
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            SoundService().playClick();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'OYUN KURALLARI',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5),
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
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _durationOptions.map((sec) {
                      final isSelected = _selectedDuration == sec;
                      return GestureDetector(
                        onTap: () {
                          SoundService().playClick();
                          setState(() => _selectedDuration = sec);
                        },
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? Colors.white : const Color(0xFF333333),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '$sec sn',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.black : const Color(0xFF94A3B8),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
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
                              color: isSelected ? const Color(0xFFFFC048) : const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFFC048) : const Color(0xFF333333),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              '$rounds Tur',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.black : const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
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
                              color: isSelected ? const Color(0xFFFF793F) : const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFF793F) : const Color(0xFF333333),
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
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Ses Efektleri', style: TextStyle(color: Colors.white, fontSize: 14)),
                          subtitle: const Text('Doğru, HUSH! ve süre sonu tonları', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                          value: _isSoundEnabled,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            SoundService().playClick();
                            setState(() => _isSoundEnabled = val);
                          },
                        ),
                        const Divider(color: Color(0xFF333333)),
                        SwitchListTile(
                          title: const Text('Titreşim (Haptik)', style: TextStyle(color: Colors.white, fontSize: 14)),
                          subtitle: const Text('Buton dokunma titreşimleri', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                          value: _isVibrationEnabled,
                          activeColor: Colors.white,
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
                color: Color(0xFF1E1E1E),
                border: Border(top: BorderSide(color: Color(0xFF333333))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onStartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  child: const Text(
                    'OYUNU BAŞLAT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
