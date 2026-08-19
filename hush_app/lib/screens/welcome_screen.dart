import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'team_setup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showHowToPlayDialog(BuildContext context) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A222D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF2C394B), width: 1.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Color(0xFFFFC048), size: 28),
            SizedBox(width: 10),
            Text(
              'Nasıl Oynanır?',
              style: TextStyle(color: Color(0xFFF8FAFC), fontWeight: FontWeight.w900),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRuleRow(
                Icons.record_voice_over,
                '1. Hedef Kelimeyi Anlat',
                'Kartın en üstündeki ana kelimeyi takım arkadaşlarına anlatmaya çalış.',
                const Color(0xFF00A8FF),
              ),
              const SizedBox(height: 14),
              _buildRuleRow(
                Icons.block,
                '2. Yasaklı Kelimeleri Kullanma!',
                'Karttaki 4 kelimeyi ve bunların köklerini kullanmak YASAKTIR. Kullanırsan HUSH! cezası alırsın.',
                const Color(0xFFFF4D4D),
              ),
              const SizedBox(height: 14),
              _buildRuleRow(
                Icons.stars,
                '3. Puanlama Sistemi',
                '• DOĞRU: +1 Puan\n• HUSH! (Yasak): -1 Ceza Puanı\n• PAS: 0 Puan (Yeni karta geçer)',
                const Color(0xFFFFC048),
              ),
              const SizedBox(height: 14),
              _buildRuleRow(
                Icons.timer,
                '4. Süre ve Turlar',
                'Her takım süre bitene kadar en çok kelimeyi bilmeye çalışır. Turlar tamamlandığında Şampiyon ve Günün Yıldızı (MVP) belirlenir!',
                const Color(0xFFFF793F),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              SoundService().playClick();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A8FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Anladım, Harika!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static Widget _buildRuleRow(IconData icon, String title, String desc, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12.5, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSettingsDialog(BuildContext context, GameProvider provider) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: const Color(0xFF1A222D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Color(0xFF2C394B)),
          ),
          title: const Row(
            children: [
              Icon(Icons.settings, color: Color(0xFF00A8FF), size: 26),
              SizedBox(width: 10),
              Text('Ayarlar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Ses Efektleri', style: TextStyle(color: Colors.white, fontSize: 14)),
                subtitle: const Text('Doğru, HUSH! ve süre sonu sesleri', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                value: provider.settings.isSoundEnabled,
                activeColor: const Color(0xFF00A8FF),
                onChanged: (val) {
                  provider.updateSettings(provider.settings.copyWith(isSoundEnabled: val));
                  setModalState(() {});
                  SoundService().playClick();
                },
              ),
              const Divider(color: Color(0xFF2C394B)),
              SwitchListTile(
                title: const Text('Titreşim (Haptik)', style: TextStyle(color: Colors.white, fontSize: 14)),
                subtitle: const Text('Dokunma geri bildirimleri', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                value: provider.settings.isVibrationEnabled,
                activeColor: const Color(0xFF00A8FF),
                onChanged: (val) {
                  provider.updateSettings(provider.settings.copyWith(isVibrationEnabled: val));
                  setModalState(() {});
                  SoundService().playClick();
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                SoundService().playClick();
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A8FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Kapat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A222D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF2C394B)),
        ),
        title: const Text('Oyundan Çıkılsın mı?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('Uygulamayı kapatmak istediğinizden emin misiniz?', style: TextStyle(color: Color(0xFF94A3B8))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Vazgeç', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4D4D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Çıkış Yap', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121820),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // Header & Logo
              Column(
                children: [
                  const SizedBox(height: 10),
                  // Animated glowing badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC048).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFC048).withOpacity(0.5)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_fire_department, color: Color(0xFFFFC048), size: 18),
                        SizedBox(width: 6),
                        Text(
                          'WORD PARTY',
                          style: TextStyle(
                            color: Color(0xFFFFC048),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Main Game Title HUSH!
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFFF4D4D), Color(0xFFFFC048), Color(0xFF00A8FF)],
                    ).createShader(bounds),
                    child: const Text(
                      'HUSH!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 58,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Kelimeleri Anlat, Yasaklara Takılma!',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Menu Options Container
              Column(
                children: [
                  // 1. OYUNA BAŞLA
                  _buildMenuButton(
                    context: context,
                    title: 'OYUNA BAŞLA',
                    subtitle: 'Takımları kur ve maceraya başla',
                    icon: Icons.play_arrow_rounded,
                    color: const Color(0xFF00A8FF),
                    isPrimary: true,
                    onTap: () {
                      SoundService().playClick();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TeamSetupScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // 2. NASIL OYNANIR?
                  _buildMenuButton(
                    context: context,
                    title: 'NASIL OYNANIR?',
                    subtitle: 'Kurallar, puanlama ve ipuçları',
                    icon: Icons.menu_book_rounded,
                    color: const Color(0xFFFFC048),
                    onTap: () => _showHowToPlayDialog(context),
                  ),
                  const SizedBox(height: 12),

                  // 3. AYARLAR
                  _buildMenuButton(
                    context: context,
                    title: 'AYARLAR',
                    subtitle: 'Ses ve titreşim tercihleri',
                    icon: Icons.tune_rounded,
                    color: const Color(0xFFFF793F),
                    onTap: () => _showSettingsDialog(context, provider),
                  ),
                  const SizedBox(height: 12),

                  // 4. ÇIKIŞ
                  _buildMenuButton(
                    context: context,
                    title: 'ÇIKIŞ',
                    subtitle: 'Uygulamadan ayrıl',
                    icon: Icons.exit_to_app_rounded,
                    color: const Color(0xFF64748B),
                    onTap: () => _showExitDialog(context),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Footer badge
              const Text(
                'v1.0 • Tek Cihaz Pass & Play',
                style: TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: color.withOpacity(0.2),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isPrimary ? color : const Color(0xFF1A222D),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPrimary ? color : const Color(0xFF2C394B),
              width: 1.5,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isPrimary ? Colors.white.withOpacity(0.2) : color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: isPrimary ? Colors.white : color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isPrimary ? Colors.white : const Color(0xFFF8FAFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: isPrimary ? Colors.white.withOpacity(0.85) : const Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isPrimary ? Colors.white : const Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
