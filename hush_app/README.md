# 📱 Tabu Özel Mobil Oyunu (Flutter)

Arkadaş grupları için özel olarak geliştirilmiş, tek cihaz üzerinden elden ele geçişli (Pass & Play) modern Tabu oyunu.

---

## 🌟 Özellikler

1. **Tek Cihazdan Çoklu Takım (Pass & Play):**
   - 2 ile 4 arasında takım desteği.
   - Her takımda 1 ile 4 arasında oyuncu tanımlama.
   - Her tura özel anlatan oyuncu rotasyonu.
2. **Kişiselleştirilebilir Oyun Kuralları:**
   - **Anlatma Süresi:** 30, 45, 60, 90, 120 saniye.
   - **Tur Sayısı:** 1, 2, 3, 4, 5 tur.
   - **Pas Hakkı:** 1, 2, 3, 5 pas veya Sınırsız pas seçeneği.
3. **100 Kelimelik Zengin Türkçe Deste:**
   - Her kelimede özenle seçilmiş 4 yasaklı kelime.
   - Deste bittiğinde otomatik yeniden karıştırma.
   - `assets/data/words.json` üzerinden kolayca yeni kelimeler ekleme.
4. **Oyun Sonu Detaylı İstatistikleri & Analiz:**
   - 🏆 Şampiyon Takım kutlaması.
   - ⭐ **Günün Yıldızı (MVP):** En yüksek net puanı toplayan anlatıcı.
   - 🥔 **Günün Talihsizi:** En düşük puanı alan oyuncu.
   - 📊 Tüm takımların puan sıralaması tablosu.
   - 📈 Tüm oyuncuların Doğru, Tabu, Pas, **İsabet Oranı (%)** ve Net Puan tablosu.
5. **Rövanş (Rematch) Sistemi:**
   - Oyun bittiğinde takımları yeniden yazmaya gerek kalmadan tek tıkla rövanş.
   - *"Önceki kurallarla devam edilsin mi?"* onayıyla anında başlama veya kuralları düzenleme.
6. **Modern Karanlık Tema & Dokunsal Geri Bildirim:**
   - Canlı neon renkler, dairesel renk değiştiren geri sayım sayacı.
   - Ses ve haptik titreşim desteği (Ayarlardan açılıp kapatılabilir).

---

## 🚀 Çalıştırma ve Test

### 1. Masaüstünde Test Etme
```bash
cd taboo_app
flutter run -d windows
```
veya Chrome tarayıcısında mobil boyutta:
```bash
flutter run -d chrome
```

### 2. Android APK Derleme
```bash
flutter build apk --release
```
Oluşan dosya: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📂 Dosya Yapısı

```
taboo_app/
├── assets/
│   └── data/
│       └── words.json          # 100 Tabu Kelimesi ve Yasaklılar
├── lib/
│   ├── models/
│   │   ├── taboo_card.dart     # Kart modeli
│   │   ├── player.dart         # Oyuncu modeli & isabet oranı
│   │   ├── team.dart           # Takım modeli
│   │   ├── game_settings.dart  # Kural ayarları
│   │   └── game_stats.dart     # MVP ve istatistik hesaplayıcı
│   ├── providers/
│   │   └── game_provider.dart  # Oyun motoru & durum yönetimi
│   ├── services/
│   │   └── sound_service.dart  # Ses ve haptik titreşim servisi
│   ├── screens/
│   │   ├── team_setup_screen.dart     # Takım & Oyuncu kurulumu
│   │   ├── game_settings_screen.dart  # Kural belirleme
│   │   ├── turn_transition_screen.dart# Cihaz devir & başlama ekranı
│   │   ├── gameplay_screen.dart       # Canlı sayaç & Tabu kartı
│   │   ├── round_summary_screen.dart  # Seans özeti
│   │   └── game_over_screen.dart      # Şampiyon, MVP & İstatistikler
│   ├── widgets/
│   │   ├── circular_timer.dart        # Dairesel geri sayım
│   │   ├── taboo_card_widget.dart     # Tabu kart bileşeni
│   │   └── action_button.dart         # Doğru / Tabu / Pas butonları
│   └── main.dart
└── pubspec.yaml
```
