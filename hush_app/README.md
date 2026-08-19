# 📱 HUSH! (Hush: Word Party) Mobil Oyunu (Flutter)

Arkadaş grupları için özel olarak geliştirilmiş, tek cihaz üzerinden elden ele geçişli (Pass & Play) modern **HUSH!** kelime anlatma oyunu.

---

## 🌟 Özellikler

1. **Tek Cihazdan Çoklu Takım (Pass & Play):**
   - 2 ile 4 arasında takım desteği.
   - Her takımda 1 ile 4 arasında oyuncu tanımlama.
   - Her tura özel anlatan oyuncu rotasyonu.
   - Örnek Takımlar: *Kırmızı Takım (Rüzgar & Enes)*, *Mavi Takım (İrem & Elif)*.
2. **Kişiselleştirilebilir Oyun Kuralları:**
   - **Anlatma Süresi:** 30, 45, 60, 90, 120 saniye.
   - **Tur Sayısı:** 1, 2, 3, 4, 5 tur.
   - **Pas Hakkı:** 1, 2, 3, 5 pas veya **Sınırsız Pas** seçeneği.
3. **100 Kelimelik Zengin Türkçe Deste:**
   - Her kelimede özenle seçilmiş 4 yasaklı kelime.
   - Deste bittiğinde otomatik yeniden karıştırma.
   - `assets/data/words.json` üzerinden kolayca yeni kelimeler ekleme.
4. **Oyun Sonu Detaylı İstatistikleri & Analiz:**
   - 🏆 Şampiyon Takım kutlaması.
   - ⭐ **Günün Yıldızı (MVP):** En yüksek net puanı toplayan anlatıcı.
   - 🥔 **Günün Talihsizi:** En düşük puanı alan oyuncu.
   - 📊 Tüm takımların puan sıralaması tablosu.
   - 📈 Tüm oyuncuların Doğru, HUSH!, Pas, **İsabet Oranı (%)** ve Net Puan tablosu.
5. **Rövanş (Rematch) Sistemi:**
   - Oyun bittiğinde takımları yeniden yazmaya gerek kalmadan tek tıkla rövanş.
   - *"Önceki kurallarla devam edilsin mi?"* onayıyla anında başlama veya kuralları düzenleme.
6. **Retro Warm Arcade Tema & Ses Efektleri:**
   - Canlı arcade renkler, dairesel renk değiştiren geri sayım sayacı.
   - Web Audio & Haptik titreşim desteği (Ayarlardan açılıp kapatılabilir).

---

## 🚀 Çalıştırma ve Test

### 1. Masaüstünde / Tarayıcıda Test Etme
```bash
cd hush_app
flutter run -d chrome
```
veya Windows masaüstü uygulaması olarak:
```bash
flutter run -d windows
```

### 2. Android APK Derleme
```bash
cd hush_app
flutter build apk --release
```
Oluşan dosya: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📂 Dosya Yapısı

```text
hush_app/
├── assets/
│   └── data/
│       └── words.json          # 100 Adet Kelime Kartı Veri Seti
├── lib/
│   ├── models/
│   │   ├── hush_card.dart      # Kelime kartı modeli
│   │   ├── player.dart         # Oyuncu modeli & isabet oranı
│   │   ├── team.dart           # Takım modeli
│   │   ├── game_settings.dart  # Kural ayarları
│   │   └── game_stats.dart     # MVP ve istatistik hesaplayıcı
│   ├── providers/
│   │   └── game_provider.dart  # Oyun motoru & durum yönetimi
│   ├── services/
│   │   ├── sound_service.dart          # Ses ve titreşim servisi
│   │   ├── sound_service_base.dart     # Ses taban arayüzü
│   │   ├── sound_service_mobile.dart   # Mobil/Masaüstü ses motoru
│   │   └── sound_service_web.dart      # HTML5 Web Audio sentezleyicisi
│   ├── screens/
│   │   ├── welcome_screen.dart        # Karşılama & Ana Menü
│   │   ├── team_setup_screen.dart     # Takım & Oyuncu kurulumu
│   │   ├── game_settings_screen.dart  # Kural belirleme
│   │   ├── turn_transition_screen.dart# Cihaz devir & başlama ekranı
│   │   ├── gameplay_screen.dart       # Canlı sayaç & HUSH! kartı
│   │   ├── round_summary_screen.dart  # Seans özeti
│   │   └── game_over_screen.dart      # Şampiyon, MVP & İstatistikler
│   ├── widgets/
│   │   ├── circular_timer.dart        # Dairesel geri sayım
│   │   ├── hush_card_widget.dart      # Kelime kart bileşeni
│   │   └── action_button.dart         # Doğru / HUSH! / Pas butonları
│   └── main.dart
└── pubspec.yaml
```
