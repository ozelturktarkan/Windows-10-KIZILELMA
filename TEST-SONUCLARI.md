# KIZILELMA test sonuçları — 30 Eylül 2026

Son ISO, sıfırdan oluşturulan sanal diske kuruldu. Ortam: VirtualBox 7.2.20, 2 GB RAM, 1 sanal işlemci, BIOS, ağ kablosu bağlantısı kapalı. Test hesapları, Guest Additions ve test otomasyonu dağıtım ISO'suna eklenmedi.

| Kontrol | Sonuç |
| --- | --- |
| İlk kullanıcı | 48 kontrol geçti |
| İkinci, standart kullanıcı | Uygulamalar yerleştikten sonra 49 kontrol geçti |
| Görsel ayarlar | 22 API/kayıt kontrolü geçti; duvar kâğıdı ve imleç uygulandı |
| Cortana kapalı, yerel arama | Başlat araması Not Defteri'ni buldu |
| Hesap Makinesi | Standart kullanıcıda 6×7=42 |
| Fotoğraflar | JPEG dosyası standart kullanıcıda açıldı |
| Windows Media Player | İlk kullanım sihirbazı tamamlandı; sessiz MP3 dosyası sona kadar oynatıldı |
| PDF yazdırma | 77.899 baytlık gerçek PDF oluşturuldu; %PDF- başlığı doğrulandı |
| .NET 3.5 | ISO'daki sources/sxs ile kuruldu; derlenen örnek program çalıştı |
| .NET 4 / PowerShell | Örnek kod derlenip çalıştırıldı |
| Güncelleme anahtarı | Açıldığında Running/Manual; kapandığında Stopped/Disabled |
| Temel korumalar | Güvenlik duvarı çalışıyor; BFE, yazdırma, arama, WMI, bakım altyapısı korunuyor |
| ISO bütünlüğü | İşlenmiş WIM hash'i eşleşiyor; BIOS ve x86 EFI kayıtları mevcut |

İkinci kullanıcının ilk ölçümünde Hesap Makinesi kaydı henüz görünmüyordu. Uygulamaya onarım uygulanmadı; normal şekilde açıldı, işlem yaptı ve sonraki kontrolde kaydı da doğrulandı. İlk profil oluşturma sırasında Fotoğraflar/Cortana etkinleştirme hata kayıtları görüldü; sonraki gerçek uygulama açılışı ve yerel arama başarılı oldu. Çevrimdışı, güncelleme hizmeti kapalı testte aktivasyon hatası kaydedildi; aktivasyon testi yapılmadı.

Bu kontroller uzun dönem kullanım, bütün sürücüler, fiziksel HDD performansı, çevrimiçi güncelleme/dil indirme veya EFI kurulum testi değildir. Bellek için sabit bir MB iddiası çıkarılmadı: test araçları ve sanal makine sürücüleri ölçümü etkiler. Ayrıntılar TEST-SONUCLARI.json içindedir.
