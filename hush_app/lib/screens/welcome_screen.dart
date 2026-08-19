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
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
        ),
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Color(0xFFFFC048), size: 28),
            SizedBox(width: 10),
            Text(
              'Nasıl Oynanır?',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
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
              backgroundColor: const Color(0xFF333333),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
            borderRadius: BorderRadius.circular(8),
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
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF333333), width: 2),
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
              const Divider(color: Color(0xFF333333)),
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
                backgroundColor: const Color(0xFF333333),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Kapat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreditsDialog(BuildContext context) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
        ),
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFFFFC048), size: 26),
            SizedBox(width: 10),
            Text('Künye / Credits', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Geliştirici:',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            const Text(
              'Umut Şimşek',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            const Text(
              'GitHub Reposu:',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            SelectableText(
              'https://github.com/UmutSimsek22/HUSH_wordparty',
              style: TextStyle(color: Colors.blue.shade300, fontSize: 12.5, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF444444)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.favorite, color: Color(0xFFFF4D4D), size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Beni bu yolda destekleyen herkese teşekkürler',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
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
              backgroundColor: const Color(0xFF333333),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Kapat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    SoundService().playClick();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // Header & Logo
              Column(
                children: [
                  const SizedBox(height: 10),
                  // Mascot icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.style, size: 50, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Main Game Title HUSH!
                  const Text(
                    'HUSH!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      fontFamily: 'Courier',
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

              const SizedBox(height: 28),

              // Menu Options Container
              Column(
                children: [
                  // 1. OYUNA BAŞLA
                  _buildMenuButton(
                    context: context,
                    title: 'OYUNA BAŞLA',
                    subtitle: 'Takımlarınızı kurun ve oyuna başlayın',
                    icon: Icons.play_arrow_rounded,
                    color: Colors.white,
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
                    color: const Color(0xFF00A8FF),
                    onTap: () => _showSettingsDialog(context, provider),
                  ),
                  const SizedBox(height: 12),

                  // 4. KÜNYE (CREDITS)
                  _buildMenuButton(
                    context: context,
                    title: 'KÜNYE (CREDITS)',
                    subtitle: 'Geliştirici ve teşekkürler',
                    icon: Icons.info_outline_rounded,
                    color: const Color(0xFFFF793F),
                    onTap: () => _showCreditsDialog(context),
                  ),
                  const SizedBox(height: 12),

                  // 5. ÇIKIŞ
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
        borderRadius: BorderRadius.circular(12),
        splashColor: color.withOpacity(0.2),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFF222222) : const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPrimary ? Colors.white : const Color(0xFF333333),
              width: isPrimary ? 2.0 : 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
