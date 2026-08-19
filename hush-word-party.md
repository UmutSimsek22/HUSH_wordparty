# 📋 Proje Planı: HUSH! (Hush: Word Party) Mobil Oyunu

> **Proje Adı:** HUSH! (Hush: Word Party)  
> **Platform:** Flutter (Mobil Android/iOS, Web, Windows) - Tek Cihaz Pass & Play  
> **Tasarım Teması:** Retro Warm Arcade (Koyu Kömür, Ateş Kırmızısı, Okyanus Mavisi, Parlak Altın)  
> **Tarih:** 2026-08-19  

---

## 🎯 Proje Hedefi & Kapsam

Telif hakkı kurallarına %100 uyumlu, özgün marka kimliği (**HUSH!**), canlı karşılama ekranı, zengin ses efektleri sentezleyicisi, kişiselleştirilebilir takım ve kural ayarları, 100 kelimelik deste ve detaylı istatistik analizleri sunan tek cihaz elden ele geçişli (Pass & Play) mobil parti oyunu.

---

## 👥 Görev Dağılımı ve Roller

| Alan | Görevli Uzman | Kullanılan Beceriler |
|---|---|---|
| Mimar & Proje Planlama | `@project-planner` / `@orchestrator` | `app-builder`, `clean-code` |
| Oyun Motoru & Ses Sentezleyici | `@game-dev-specialist` | `game-development`, `systematic-debugging` |
| UI/UX & Mobil Tasarım | `@frontend-specialist` | `mobile-design`, `design-spec` |
| Kalite Kontrol & Testler | `@qa-specialist` | `lint-and-validate`, `verify-changes` |

---

## 🗓️ Faz Bazlı Uygulama Adımları

### Faz 1: Proje Yeniden Yapılandırma & Dizin Temizliği (GitHub & Telif Uyumu)
- [ ] Proje dizinini `taboo_app` adından `hush_app` adına dönüştürme.
- [ ] Telif içeren eski referansları tamamen temizleme.
- [ ] `pubspec.yaml` paket adını `hush_party` olarak sabitleme.

### Faz 2: Retro Warm Arcade Tasarım Sistemi & `DESIGN.md` Güncellemesi
- [ ] Mor ve yeşil renkleri tamamen çıkarma.
- [ ] Renk Paleti:
  - Zemin: Koyu Kömür (`#121820` / `#1A222D`)
  - Ateş Kırmızısı: `#FF4D4D` (Kırmızı Takım & HUSH! Cezası)
  - Okyanus Mavisi: `#00A8FF` (Mavi Takım & Doğru Aksiyonu)
  - Parlak Altın: `#FFC048` (Sarı Takım, Sayaç & Şampiyon Rozeti)
  - Sıcak Kehribar/Turuncu: `#FF793F` (Turuncu Takım & Pas Aksiyonu)

### Faz 3: Karşılama Ekranı (Welcome / Main Menu Screen)
- [ ] `lib/screens/welcome_screen.dart` oluşturma:
  - Animasyonlu **HUSH!** logosu ve *Word Party* alt başlığı.
  - 🚀 **Oyuna Başla**: Takım & Oyuncu Kurulumuna yönlendirir.
  - 📖 **Nasıl Oynanır?**: Kuralları ve puanlamayı (+1 Doğru, -1 HUSH!, 0 Pas) anlatan şık modal/dialog.
  - ⚙️ **Ayarlar**: Ses, titreşim ve tema tercihleri modalı.
  - 🚪 **Çıkış**: Oyundan çıkış onayı.

### Faz 4: Ses Efektleri Sentezleyicisi (Web Audio Engine)
- [ ] `lib/services/sound_service.dart` güçlendirme:
  - Tarayıcıda ve mobilde sıfır gecikmeli Web Audio sentezleyici (HTML5 AudioContext):
    - Tıklama sesi (Hafif pop)
    - Doğru sesi (Pozitif yüksek çift ton)
    - HUSH! / Yasak sesi (Alçak frekanslı buzzer tonu)
    - Pas sesi (Kaydırma tonu)
    - Son 5 saniye sayaç uyarısı (Tik-tak bip sesleri)
    - Süre bitti sesi (Gong / alarm)
    - Şampiyon kutlama melodisi

### Faz 5: Takım & Oyuncu Kurulumu Güncellemesi
- [ ] Örnek takım ve oyuncu isimlerini güncelleme:
  - **Kırmızı Takım:** Rüzgar & Enes
  - **Mavi Takım:** İrem & Elif
- [ ] Kullanıcının bu isimleri dilediği gibi düzenleyebilmesi veya 4 takıma/4'er oyuncuya kadar genişletebilmesi.

### Faz 6: Kural Ayarları & Sınırsız Pas
- [ ] `lib/screens/game_settings_screen.dart` içinde:
  - Seans Süresi: 30, 45, 60, 90, 120 sn
  - Tur Sayısı: 1, 2, 3, 4, 5 tur
  - Pas Hakkı: 1, 2, 3, 5 pas ve **Sınırsız Pas** butonu

### Faz 7: Canlı Oyun, Tur Özeti, Oyun Sonu & Rövanş
- [ ] `gameplay_screen.dart`: Retro Warm renklerinde büyük HUSH! kartı, dairesel altın sayaç, Okyanus Mavisi Doğru (+1), Ateş Kırmızısı HUSH! (-1), Kehribar Pas (0) butonları.
- [ ] `round_summary_screen.dart`: Seans özeti.
- [ ] `game_over_screen.dart`: Şampiyon kutlaması, MVP ve Günün Talihsizi, Takım Sıralaması, Oyuncu Doğruluk Oranı (%) Tablosu, Rövanş butonu.

---

## 🔍 Doğrulama ve Test Kriterleri

1. **Test Doğrulaması:** `flutter test` ile tüm birim ve widget testlerinin 4/4 geçmesi.
2. **Ses Doğrulaması:** Chrome ve mobilde butonlara basıldığında seslerin anında duyulması.
3. **Akış Doğrulaması:** Karşılama Ekranı -> Takım Kurulumu -> Kurallar -> Oyun -> İstatistikler -> Rövanş zincirinin kusursuz çalışması.

---

## 🚀 Sonraki Adım

Planı onayladıktan sonra `/create` komutu ile uygulamayı başlatabiliriz.
