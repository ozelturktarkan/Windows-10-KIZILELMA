# Windows 10 KIZILELMA

**Türkçe Windows 10 Home 1607 · 32 bit · Temel masaüstü deneyimi**

KIZILELMA, eski bilgisayarlar için hangi bileşenlerin kaldırıldığını ve hangi ayarların değiştirildiğini açıkça gösteren bir Windows özelleştirmesidir. Hedef donanım **2 GB RAM + HDD**; imkân varsa SSD önerilir. Bu depoda Windows ISO'su yerine NTLite ön ayarları, açık betikler, üretim tarifi, test sonuçları ve ISO hash değerleri bulunur.

## Yalnız imleç veya arka plan istiyorum

| Dosya | İndir | Kullanım |
| --- | --- | --- |
| Dalgalanan Türk bayrağı imleci | [turk.ani](https://github.com/ozelturktarkan/Windows-10-KIZILELMA/releases/download/v1.0-genislet/turk.ani) | Fare > İşaretçiler > Normal Seçim > Gözat |
| KIZILELMA arka planı | [KIZILELMA.jpg](https://github.com/ozelturktarkan/Windows-10-KIZILELMA/releases/download/v1.0-genislet/KIZILELMA.jpg) | Masaüstü arka planı; yerleşim: Genişlet |

Bu dosyalar için Windows'u yeniden kurmanız veya NTLite edinmeniz gerekmez. [Kurulum adımları ve dosya özetleri](assets/README.md). Dosyalar ayrıca [assets klasöründe](assets) ayrı ayrı bulunur.

<img src="assets/KIZILELMA.jpg" alt="Windows 10 KIZILELMA arka planı" width="720">

## ISO indirme durumu

**Internet Archive bağlantısı henüz eklenmedi.** Büyük ISO dosyasını proje sahibi ayrıca yükleyecek. Bu depodaki veya GitHub Releases'taki kaynak ZIP dosyaları Windows kurulum ISO'su değildir. ISO yüklemesi tamamlandığında bağlantı buraya eklenecek.

| Özellik | Değer |
| --- | --- |
| Taban | Windows 10 Home 1607, 10.0.14393.0 |
| Dil / mimari | Türkçe / x86 (32 bit) |
| Kurulum indeksi | Yalnız Home, indeks 1 |
| Son yapılandırma | Genişlet arka plan revizyonu, 30 Eylül 2026 |
| ISO adı | Windows 10 KIZILELMA.iso |
| Boyut | 2.645.475.328 bayt; yaklaşık 2,46 GiB |

## Güvenmek yerine inceleyin, kendiniz üretin

Uygun NTLite lisansını edinip kendi Türkçe Windows 10 Home 1607 x86 kaynağınız üzerinde [uygulanan XML'i](NTLite-KIZILELMA-Uygulanan.xml), **betikler ve medya ekiyle birlikte** kullanarak aynı yapılandırmayı hazırlayabilirsiniz. [Yeniden üretim kılavuzu](YENIDEN-URETIM.md) bütün adımları anlatır.

Yalnız XML, duvar kâğıdı ve diğer kişiselleştirmeleri üretmez. NTLite sürümü, sıkıştırma ve zaman damgaları farklı olabileceğinden bayt bayt aynı ISO/hash garantisi verilmez. Tarifin ayrı bir temiz NTLite çalıştırmasıyla uçtan uca yeniden üretim karşılaştırması yapılmadı.

Başlangıç Windows kaynağını proje sahibi [bu Internet Archive dizininden](https://archive.org/download/win10-1607) edindiğini bildirdi. Bu bağlantı **KIZILELMA indirme bağlantısı değildir** ve Microsoft'un resmî indirme sunucusu değildir. Temiz Home WIM ve işlenmiş WIM özetleri [üretim tarifinde](YENIDEN-URETIM.md) / [sürüm kaydında](SURUM.json) belgelenmiştir.

## Neler değişti?

- Store, Defender, OneDrive, Xbox uygulamaları ve çeşitli tanıtım/yerleşik uygulamalar kaldırıldı. Tam liste: [NTLite-KIZILELMA-Uygulanan.xml](NTLite-KIZILELMA-Uygulanan.xml), 23 girdi.
- Cortana kapalı; **yerel Başlat araması, SearchUI ve WSearch korunuyor**.
- Paint, Not Defteri, WordPad, Hesap Makinesi, Fotoğraflar, Windows Media Player, yazdırma/PDF ve temel ağ/servis altyapısı korunuyor.
- Windows güvenlik duvarı korunuyor. İmaja üçüncü taraf antivirüs eklenmedi; kullanıcı ayrıca kurar.
- Xbox kayıt arayüzü kaldırıldı, Game DVR kaydı kapalı. **Bazı yerel DVR sistem dosyaları hâlâ mevcut**; bütün dosyalarının silindiği iddia edilmiyor.
- Animasyonlar ve saydamlık kapalı; okunabilirlik ve temel seçim göstergeleri korunuyor. Arka plan **Genişlet**, normal imleç dalgalanan Türk bayrağı.
- DiagTrack kapalı. Pagefile, bellek sıkıştırması, SysMain ve işlemci/güç planı varsayılanları korunuyor. HPET veya yüzde 100 işlemci alt sınırı gibi ayarlar eklenmiyor.
- Türkçe Q varsayılan. Sonradan dil/klavye ekleme altyapısı korunuyor; font ve klavye dosyaları topluca silinmedi.

[Ayrıntılı kararlar ve bilinen sınırlar](Kararlar.md)

## Güncellemeler nasıl yönetilir?

Windows Update hizmeti başlangıçta kapalıdır; bakım/bileşen dosyaları korunur. Masaüstündeki **KIZILELMA - Guncelleme yonetimi** kısayolunda **1** hizmeti açar, **2** kapatır, **3** Windows Update ayarlarını açar. Hizmet değişikliği için yönetici onayı gerekir.

Güncelleme, WUSA veya internetten .NET/dil bileşeni yüklemeden önce hizmeti açın. Hizmet açıkken Windows arka planda da arama yapabilir; işlem bitince kapatabilirsiniz. 99 yıl erteleme hilesi kullanılmıyor.

## Son ISO'nun hash değerleri

```text
SHA-256  f86479abd9f857f63e844bc47f2fadd1c134c55d76c306e666593dd339c3114f
SHA-1    9eb6ca19f1a4a9bc973425f8c51ed49ca1713572
MD5      ed9e920caa80a46837f72df8349e8ecd
```

[HASHES.txt](HASHES.txt) — Doğrulamada SHA-256'yı esas alın. PowerShell örneği:

```powershell
Get-FileHash -LiteralPath '.\Windows 10 KIZILELMA.iso' -Algorithm SHA256
```

Hash eşleşmesi, dosyanın belirtilen sürümle aynı olduğunu gösterir; güvenlik sertifikası değildir.

## Neler test edildi?

Önceki Sığdır revizyonu VirtualBox 7.2.20'de 2 GB RAM, 1 sanal işlemci ve BIOS ile temiz kuruldu. İlk kullanıcıda 48, ikinci standart kullanıcıda uygulamalar yerleştikten sonra 49 kontrol geçti. Yerel arama, Hesap Makinesi, Fotoğraflar, MP3 oynatma, gerçek PDF yazdırma, .NET 3.5 kurulumu ve güncelleme hizmeti anahtarı denetlendi.

**Son Genişlet revizyonunda kurulum testi tekrarlanmadı.** Aynı Windows WIM'i kullanıldı; değişen arka plan betiği/tema dosyalarının ISO içinde doğru bulunduğu ve hash'ler doğrulandı. Önceki testleri bu son ISO üzerinde tekrar yapılmış gibi sunmuyoruz. [Test sonuçları](TEST-SONUCLARI.md) · [Son arka plan değişikliği](ARKAPLAN-GUNCELLEMESI.md)

Gerçek 2 GB HDD bilgisayarda uzun dönem kullanım, bütün sürücüler, çevrimiçi güncelleme/dil indirme ve EFI kurulumu test edilmedi. Bu nedenle "her bilgisayarda sorunsuz", "en hafif" veya sabit RAM tüketimi garantisi verilmiyor.

## Kaynaklar ve kullanım sınırları

Windows 10 Home 1607 destek dışı bir tabandır; bu proje güvenlik güncellemesi veya uzun dönem kararlılık garantisi sağlamaz. Kaynak paketi Windows lisansı, ürün anahtarı veya aktivasyon aracı içermez. Windows dosyalarının hakları bu depoyu paylaşmakla değişmez. İmleç ve görsel proje sahibi tarafından sağlandı; bunlar için ayrıca bir üçüncü taraf kullanım lisansı beyan edilmedi.

Kurulum medyası hazır kullanıcı/parola, otomatik disk silme veya sanal makineye özel Guest Additions içermez. Kullanıcı kendi disk ve hesap seçimlerini yapar. Sorun bildirirken donanım/sanallaştırma bilgilerini ve tekrar üretme adımlarını [Issues](https://github.com/ozelturktarkan/Windows-10-KIZILELMA/issues) bölümüne yazabilirsiniz; ürün anahtarı ve kişisel verileri paylaşmayın.
