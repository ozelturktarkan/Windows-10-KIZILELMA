# Windows 10 KIZILELMA r1 — kararlar

Windows 10 Home 1607 Türkçe x86, tek Home indeksi. Hedef 2 GB RAM ve HDD; SSD önerilir. Temiz kurulum 2 GB RAM ve 1 sanal işlemciyle sınandı; gerçek 2 GB HDD bilgisayarda uzun süreli kullanım henüz ölçülmedi. Home 1607 destek dışıdır; uzun dönem güvenlik/kararlılık garantisi verilmiyor.

## Kullanıcının son kararları

- Cortana kapalı; SearchUI ve WSearch üzerinden yerel arama korunacak.
- Microsoft Store kaldırıldı. Hesap Makinesi ve Fotoğraflar korundu; Store olmadan standart kullanıcıda açılışları doğrulandı. Store uygulama güncellemesi sunulmuyor.
- Defender kaldırıldı; Kaspersky Free kullanıcı tarafından daha sonra kurulacak, imaja gömülmedi. Güvenlik duvarı, BFE ve Güvenlik Merkezi korunacak.
- Xbox uygulamaları/kayıt arayüzü kaldırıldı ve Game DVR kayıt ayarları kapalı. **Bütün DVR dosyaları kaldırılmadı:** bcastdvr.exe, bcastdvr.proxy.dll, BcastDVRHelper.dll, GameBarPresenceWriter.exe, GameBarPresenceWriter.proxy.dll ve Windows.Gaming.UI.GameBar.dll System32 içinde mevcut. Bu sürüm için "Game DVR bütün dosyalarıyla silindi" iddiasında bulunulmuyor.
- Animasyonlar/saydamlık kapalı. ClearType, simge yazısı gölgesi, küçük resimler ve seçim dikdörtgeni kullanılabilirlik için korunur. İstenen turk.ani normal fare imlecidir; bu animasyon kullanıcı isteğinin istisnasıdır. Diğer imleç rolleri standart kalır.
- Türkçe Q varsayılan. Sonradan dil/klavye ekleme desteği korunur; dil/font/klavye dosyaları körlemesine silinmez.
- Windows Update altyapısı korunur. NoAutoUpdate=1 ek olarak uygulanır; otomatik çalışma hizmetin varsayılan olarak kapalı tutulmasıyla durdurulur. Masaüstündeki Güncelleme yönetimi aracı, yönetici onayıyla hizmeti açıp kapatır. Güncelleme veya internetten isteğe bağlı bileşen yüklemeden önce açılmalıdır. Açık modda arka plan güncelleme araması yapılabilir; iş bitince kapatılır. 99 yıl erteleme hilesi kullanılmıyor. Hizmetin açılıp Running, kapatılıp Stopped/Disabled durumuna geçtiği temiz kurulumda doğrulandı. Ağdan güncelleme/dil paketi indirmesi ve aktivasyon bu çevrimdışı testte sınanmadı.

## Korunan günlük işlevler

Paint, WordPad, Not Defteri, Hesap Makinesi, Fotoğraflar, Windows Media Player, ses/video, yazdırma/PDF, kamera/tarayıcı, ağ paylaşımı, Wi-Fi/Bluetooth/USB, sürücü kurulumu, WinRE/sistem geri yükleme, Windows Installer, .NET, PowerShell, WMI ve performans sayaçları.

UMAY'ın SSDPSRV/OneSync kapatmaları aktarılmadı. DiagTrack kapalı. SysMain/prefetch, pagefile, bellek sıkıştırması, güç planı ve işlemci/zamanlayıcı ayarları kaynak varsayılanında kalır. Hiçbir donanım sürücüsü hazırlayan bilgisayara göre elenmez.

## Üretim ve test durumu

NTLite kaldırması, temiz 2 GB VM kurulumu, ikinci standart kullanıcı, arama/uygulama/PDF yazdırma/.NET ve güncelleme anahtarı kontrolleri tamamlandı. Test kapsamı TEST-SONUCLARI.md dosyasında belirtilmiştir. Gerçek 2 GB HDD bilgisayar ve uzun kullanım testi ayrıca gereklidir. Kaynak XML ve medya eki birlikte üretim tarifidir; yalnız XML tüm ayarları üretmez.

Arka plan son revizyonda Genişlet (WallpaperStyle=2) olarak ayarlandı. Bu revizyon için yeni sanal makine kurulumu yapılmadı.
