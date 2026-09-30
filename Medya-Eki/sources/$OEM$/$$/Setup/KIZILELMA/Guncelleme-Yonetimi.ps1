param([ValidateSet('Menu','Enable','Disable','Status')][string]$Mode='Menu')
$ErrorActionPreference='Stop'
if($PSScriptRoot -ine (Join-Path $env:SystemRoot 'Setup\KIZILELMA')){throw 'KIZILELMA kurulum klasörü gerekli.'}
$os=Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
if([Environment]::Is64BitOperatingSystem -or $os.CurrentBuildNumber -ne '14393' -or $os.EditionID -ne 'Core' -or (Get-ItemProperty 'HKLM:\SOFTWARE\KIZILELMA').ProfileId -ne 'KIZILELMA-1607-x86-r1'){throw 'Bu araç Windows 10 KIZILELMA 1607 içindir.'}
function Show-State {
 $start=(Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv').Start
 $service=Get-Service wuauserv
 if($start -eq 4 -and $service.Status -eq 'Stopped'){Write-Host 'Güncelleme hizmeti KAPALI.' -ForegroundColor Green}
 elseif($start -eq 4){Write-Host ('Hizmet devre dışı; durumu: '+$service.Status) -ForegroundColor Yellow}
 else {Write-Host ('Güncelleme hizmeti AÇIK. Durum: '+$service.Status) -ForegroundColor Yellow;Write-Host 'Bu modda Windows arka planda da güncelleme arayabilir. İşiniz bitince kapatabilirsiniz.'}
}
if($Mode -eq 'Status'){Show-State;exit 0}
if($Mode -eq 'Menu'){
 $Host.UI.RawUI.WindowTitle='KIZILELMA - Güncelleme yönetimi'
 do {
  Clear-Host
  Write-Host 'Windows 10 KIZILELMA — Güncelleme yönetimi'
  Show-State
  Write-Host "`n1 - Güncelleme hizmetini aç"
  Write-Host '2 - Güncelleme hizmetini kapat'
  Write-Host '3 - Windows Update ayarlarını aç'
  Write-Host '0 - Çıkış'
  Write-Host "`nWindows Update, internetten .NET/dil bileşeni indirme veya WUSA ile güncelleme yükleme öncesinde hizmeti açın."
  $choice=Read-Host 'Seçiminiz'
  if($choice -in @('1','2')){
   $action=if($choice -eq '1'){'Enable'}else{'Disable'}
   $launchArguments='-NoProfile -ExecutionPolicy Bypass -File "'+$PSCommandPath+'" -Mode '+$action
   try {Start-Process "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -Verb RunAs -ArgumentList $launchArguments -Wait|Out-Null}catch{Write-Host 'İşlem başlatılamadı veya yönetici onayı verilmedi.' -ForegroundColor Yellow}
   Show-State
   Read-Host 'Devam etmek için Enter'|Out-Null
  } elseif($choice -eq '3'){Start-Process 'ms-settings:windowsupdate'}
 }while($choice -ne '0')
 exit 0
}
$p=New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not$p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'Değişiklik için yönetici yetkisi gerekli.'}
try {
 if($Mode -eq 'Enable'){
  Set-Service wuauserv -StartupType Manual
  Start-Service wuauserv
  (Get-Service wuauserv).WaitForStatus('Running',[TimeSpan]::FromSeconds(40))
  Write-Host 'Güncelleme hizmeti açıldı. İşiniz bitince bu araçla kapatabilirsiniz.' -ForegroundColor Green
 }else{
  Set-Service wuauserv -StartupType Disabled
  Stop-Service wuauserv -ErrorAction Stop
  (Get-Service wuauserv).WaitForStatus('Stopped',[TimeSpan]::FromSeconds(40))
  Write-Host 'Güncelleme hizmeti kapatıldı. Bileşen dosyaları korunuyor.' -ForegroundColor Green
 }
 Write-Output ('KIZILELMA_UPDATE_MODE='+$Mode)
}catch{Write-Host $_.Exception.Message -ForegroundColor Red;exit 1}