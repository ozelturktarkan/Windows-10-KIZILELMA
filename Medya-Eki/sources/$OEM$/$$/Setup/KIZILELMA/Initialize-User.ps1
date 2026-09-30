$ErrorActionPreference='Stop'
Set-StrictMode -Version 2
if($PSScriptRoot -ine (Join-Path $env:SystemRoot 'Setup\KIZILELMA')){throw 'KIZILELMA hedef klasoru gerekli.'}
$profile=Get-ItemProperty 'HKLM:\SOFTWARE\KIZILELMA'
if($profile.ProfileId -ne 'KIZILELMA-1607-x86-r1' -or $profile.MachineComplete -ne 1){throw 'KIZILELMA kurulumu tamamlanmadi.'}
if(Test-Path 'HKCU:\Software\KIZILELMA\Initialized'){exit 0}
function Put($Key,$Name,$Value,$Kind='DWord'){
 if(-not(Test-Path -LiteralPath $Key)){New-Item -Path $Key -Force|Out-Null}
 New-ItemProperty -LiteralPath $Key -Name $Name -Value $Value -PropertyType $Kind -Force|Out-Null
}
$out=Join-Path $env:LOCALAPPDATA 'KIZILELMA';New-Item -ItemType Directory -Path $out -Force|Out-Null
Start-Transcript -Path (Join-Path $out 'FirstLogon.log') -Append|Out-Null
try {
 $base='HKCU:\Software\Microsoft\Windows\CurrentVersion'
 Put ($base+'\Explorer\Advanced') 'HideFileExt' 0
 Put ($base+'\Search') 'SearchboxTaskbarMode' 1
 Put ($base+'\Search') 'BingSearchEnabled' 0
 Put ($base+'\Search') 'CortanaConsent' 0
 Put ($base+'\AdvertisingInfo') 'Enabled' 0
 foreach($name in @('SilentInstalledAppsEnabled','SoftLandingEnabled','SystemPaneSuggestionsEnabled','PreInstalledAppsEnabled','OemPreInstalledAppsEnabled')){Put ($base+'\ContentDeliveryManager') $name 0}
 Put ($base+'\GameDVR') 'AppCaptureEnabled' 0
 Put 'HKCU:\System\GameConfigStore' 'GameDVR_Enabled' 0
 $wallpaper=Join-Path $env:SystemRoot 'Web\Wallpaper\KIZILELMA\KIZILELMA.jpg'
 $cursor=Join-Path $env:SystemRoot 'Cursors\KIZILELMA\turk.ani'
 foreach($file in @($wallpaper,$cursor)){if(-not(Test-Path -LiteralPath $file)){throw ('Eksik gorsel dosya: '+$file)}}
 Put 'HKCU:\Control Panel\Cursors' 'Arrow' $cursor 'String'
 Put 'HKCU:\Control Panel\Desktop' 'Wallpaper' $wallpaper 'String'
 Put 'HKCU:\Control Panel\Desktop' 'WallpaperStyle' '2' 'String'
 Put 'HKCU:\Control Panel\Desktop' 'TileWallpaper' '0' 'String'
 Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class KizilelmaDesktop {
 [DllImport("user32.dll",CharSet=CharSet.Unicode,SetLastError=true)]
 [return:MarshalAs(UnmanagedType.Bool)]
 public static extern bool SystemParametersInfo(uint action,uint param,string value,uint flags);
 [DllImport("user32.dll",EntryPoint="SystemParametersInfoW",SetLastError=true)]
 [return:MarshalAs(UnmanagedType.Bool)]
 static extern bool SpiPointer(uint action,uint param,IntPtr value,uint flags);
 public static bool ReloadCursors(){return SpiPointer(87,0,IntPtr.Zero,0);}
}
'@
 if(-not[KizilelmaDesktop]::SystemParametersInfo(20,0,$wallpaper,3)){throw 'Arkaplan uygulanamadi.'}
 if(-not[KizilelmaDesktop]::ReloadCursors()){throw 'Imlec uygulanamadi.'}
 & (Join-Path $PSScriptRoot 'Set-VisualEffects.ps1')
 New-Item 'HKCU:\Software\KIZILELMA\Initialized' -Force|Out-Null
 Write-Output 'KIZILELMA ilk oturum tamamlandi. Sonraki oturumlarda tercihleriniz korunur.'
} catch {Write-Output ($_|Out-String);throw} finally {Stop-Transcript|Out-Null}
