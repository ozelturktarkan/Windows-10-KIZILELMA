# Windows 10 KIZILELMA üretim tarifi

Taban: Türkçe Windows 10 Home 1607 x86, 10.0.14393.0. Bu tarif bu sürüm içindir. `NTLite-KIZILELMA-Uygulanan.xml` gerçekten uygulanan kaldırma ve uyumluluk seçimleridir. `NTLite-KIZILELMA.xml` başlangıçta talep edilen seçimleri gösterir. **Yalnız XML, kişiselleştirmeleri üretmez; Medya-Eki de gerekir.**

1. Temiz, kendi edindiğiniz Windows 10 1607 x86 kurulum medyasını ayrı bir klasöre çıkarın. Home dışındaki indeksleri NTLite ile kaldırıp Home'u tek indeks olarak dışa aktarın. Bizim temiz Home WIM SHA-256 değerimiz: `9422345a554c2f36348efda09f8eac566287a6d23cc0b7f17bfcc621e10d922b`.
2. NTLite 2026.9.11904 ile Home indeksini yükleyin. Uygulanan XML'i içe aktarın; kaldırma listesini gözden geçirip değişiklikleri WIM'e kaydedin. NTLite lisansı bu paketle verilmez. XML'deki uyumluluk korumasının `no` olması, ilgili bileşenin silindiği anlamına gelmez; kaldırmalar `RemoveComponents` listesindedir.
3. Python 3.11 veya üstünde `python -m pip install -r requirements.txt` ile ISO aracının bağımlılığını kurun. İşlenmiş kaynak klasörünü aşağıdaki komutta belirtin. Çıktı dosyası önceden varsa araç üzerine yazmaz.

```powershell
python tools/Build-ISO.py --source "V:\Islenmis-KIZILELMA" --overlay "Medya-Eki" --output "V:\Windows 10 KIZILELMA.iso" --report "V:\KIZILELMA-ISO-sonucu.json"
```

Komutu bu kaynak klasöründe çalıştırın. Araç `Medya-Eki` dosyalarını ISO'ya ekler; işlenen kaynak klasörüne yazmaz. Kaynak medyanın kökündeki NTLite logları/ön ayar XML'leri ISO'ya alınmaz. BIOS ve x86 EFI açılış kayıtları oluşturulur.

4. ISO'yu temiz sanal diskte kurarak deneyin. Bu üretim medyası sabit kullanıcı hesabı, parola, otomatik oturum açma, ürün anahtarı veya otomatik disk silme talimatı içermez. Kullanıcı kurulumda kendi seçimlerini yapar. Test otomasyonumuz ayrı tutulmuştur.
5. Kendi ISO'nuzun SHA-256 özetini kaydedin. Aynı tarif, ayarları yeniden üretmeye yarar. NTLite sürümü, WIM sıkıştırması ve zaman damgaları farklıysa ISO baytları/hash'i aynı çıkmayabilir; bit düzeyinde birebir sonuç garantisi verilmez.

Kurulum akışı: `autounattend.xml` içindeki specialize komutu `Apply-Machine.ps1` betiğini yalnız kurulumun SYSTEM bağlamında çalıştırır. Varsayılan kullanıcı kaydındaki RunOnce girdisi, her yeni kullanıcı için `Initialize-User.ps1` betiğini bir kez başlatır. Sonraki oturumlarda kullanıcının tercihleri yeniden zorlanmaz. Görsel efektler `Set-VisualEffects.ps1` ile Windows API'sinden ayarlanır.

Windows dosyaları veya lisansı bu küçük kaynak paketinin lisansı altında değildir. Bu tarif aktivasyon sağlamaz. Duvar kâğıdı ve imleç kullanıcı tarafından sağlanan varlıklardır; kaynak/kullanım hakları ayrıca değerlendirilmelidir.

1607 uyumluluk düzeltmesi: Apply-Machine.ps1 içindeki FrameworkCompatibility bölümü, NTLite işlemi sonrasında dört mevcut bağımlılık için eklenen bağımsız Applications kayıtlarını temiz Home kaynak yapısıyla eşleştirir. Staged kayıtları, uygulamaların bağımlılık alt anahtarları ve kitaplık dosyaları korunur. İlk adayda Windows olay 809 ile bu kitaplıkları sideloading kısıtlaması nedeniyle kaldırıyordu. Bu dar düzeltmeden sonraki temiz kurulumda Hesap Makinesi, Fotoğraflar ve Kamera kayıtları doğrulandı. Sideloading veya lisans denetimi kapatılmaz.

Güncelleme denetimi: Guncelleme-Yonetimi.ps1 yalnız KIZILELMA 14393 Home x86 üzerinde çalışır. Kurulum wuauserv hizmetini kapatır ve ortak masaüstüne bir kısayol ekler. Araç, kullanıcının açık seçimi ve Windows yönetici onayıyla hizmeti elle başlatır/devre dışı bırakır; BITS, bileşen deposu, TrustedInstaller ve dil/.NET dosyaları kaldırılmaz. Hizmet açıkken Windows otomatik arama yapabilir. Bu adımın amacı Home sürümünde ilke kaydının davranışına bağlı kalmadan kullanıcının istediği güncelleme denetimini sağlamaktır.
