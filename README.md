# 🤫 HUSH! (Hush: Word Party)

<p align="center">
  <h2 align="center">Kelimeleri Anlat, Yasaklara Takılma!</h2>
  <p align="center">
    Tek Cihaz Üzerinden Elden Ele (Pass & Play) Oynanan Mobil Parti Oyunu
  </p>
</p>

---

## 🌟 Oyun Hakkında

**HUSH! (Hush: Word Party)**, arkadaş ortamlarında tek bir mobil veya masaüstü cihaz üzerinden oynanabilen, yüksek tempolu ve eğlenceli bir yasaklı kelime anlatma oyunudur. 

Ticari marka haklarına %100 uyumlu şekilde özgün bir tasarım, özel renk paleti (**Retro Warm Arcade**) ve özelleştirilebilir kurallarla geliştirilmiştir.

---

## 🔥 Öne Çıkan Özellikler

- 📱 **Tek Cihaz Pass & Play:** İnternet bağlantısı veya birden fazla cihaz gerektirmez. Cihazı anlatıcı oyuncuya vermeniz yeterlidir.
- 👥 **Esnek Takım & Oyuncu Yönetimi:**
  - 2 ila 4 takım kurulabilir.
  - Her takımda 1 ila 4 oyuncu yer alabilir.
  - Oyuncu ve takım isimleri dilediğiniz gibi düzenlenebilir (Varsayılan: *Kırmızı Takım: Rüzgar & Enes*, *Mavi Takım: İrem & Elif*).
- ⚙️ **Özelleştirilebilir Oyun Kuralları:**
  - **Seans Süresi:** 30, 45, 60, 90, 120 saniye.
  - **Tur Sayısı:** 1 ila 5 tur.
  - **Pas Hakkı:** 1, 2, 3, 5 pas veya **Sınırsız Pas** hakkı.
- 🔊 **Zengin Ses Efektleri:** Doğru (+1), HUSH! (-1), Pas (0), sayaç uyarısı ve süre bitti gong tonları.
- 📊 **Detaylı Oyun Sonu İstatistikleri:**
  - Şampiyon Takım Kutlaması.
  - **Günün Yıldızı (MVP)** ve **Günün Talihsizi** madalyaları.
  - Takım Sıralama Tablosu.
  - Tüm oyuncular için **İsabet Oranı (%)** ve Net Puan performans matrisi.
- 🔄 **Hızlı Rövanş Sistemi:** Mevcut takımları koruyarak ister aynı kurallarla ister kuralları değiştirerek anında yeni maça başlama.

---

## 🎮 Nasıl Oynanır?

1. **Oyuna Başla** butonuna tıklayarak takımlarınızı ve oyuncularınızı belirleyin.
2. Tur süresini, tur sayısını ve pas hakkınızı ayarlayın.
3. Ekran sırası gelen oyuncu cihazı eline alır ve **SÜREYİ BAŞLAT** butonuna basar.
4. Anlatıcı, kartın en üstündeki ana kelimeyi takım arkadaşlarına anlatmaya çalışır:
   - **DOĞRU (+1 Puan):** Kelime bildiğinde tıklanır.
   - **HUSH! (-1 Ceza):** Yasaklı kelimelerden biri kullanıldığında tıklanır.
   - **PAS (0 Puan):** Anlatılamayan kelimelerde yeni karta geçmek için kullanılır.
5. Süre bittiğinde sıradaki takıma geçilir. Tüm turlar tamamlandığında şampiyon ve istatistikler açıklanır!

---

## 🚀 Projeyi Yerel Kurulum ile Çalıştırma

### Gereksinimler
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.0.0 veya üzeri)

### Adımlar

1. Depoyu klonlayın:
   ```bash
   git clone https://github.com/UmutSimsek22/HUSH_wordparty.git
   cd HUSH_wordparty/hush_app
   ```

2. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```

3. Uygulamayı çalıştırın:
   ```bash
   # Tarayıcıda (Chrome) mobil görünümde çalıştırmak için:
   flutter run -d chrome

   # Windows masaüstü uygulaması olarak çalıştırmak için:
   flutter run -d windows
   ```

---

## 📂 Proje Dizin Yapısı

```text
HUSH_wordparty/
├── hush_app/                 # Ana Flutter Uygulama Klasörü
│   ├── assets/
│   │   └── data/words.json   # 100 Adet Kelime Kartı Veri Seti
│   ├── lib/
│   │   ├── models/           # Oyuncu, Takım, İstatistik ve Kart Modelleri
│   │   ├── providers/        # Oyun Durumu ve Zamanlayıcı Yöneticisi (State)
│   │   ├── screens/          # Karşılama, Kurulum, Kurallar, Oyun ve İstatistik Ekranları
│   │   ├── services/         # Ses ve Titreşim Servisi
│   │   └── widgets/          # Dairesel Sayaç, Kart ve Buton Bileşenleri
│   └── test/                 # Birim ve Widget Testleri
├── DESIGN.md                 # Tasarım Özellikleri ve Renk Paleti Dokümanı
├── hush-word-party.md        # Proje Planı
└── README.md                 # Proje Dokümantasyonu
```

---

## 🛡️ Lisans & Telif Bilgisi

Bu proje özgün bir parti oyunu olarak geliştirilmiştir. **HUSH!** ismi, tasarımı ve kod mimarisi üçüncü taraf tescilli markaların haklarını ihlal etmeyecek şekilde bağımsız olarak tasarlanmıştır.

MIT Lisansı ile lisanslanmıştır.
