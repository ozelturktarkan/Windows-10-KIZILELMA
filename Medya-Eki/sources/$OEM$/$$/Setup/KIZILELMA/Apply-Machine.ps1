$ErrorActionPreference='Stop'
Set-StrictMode -Version 2
$expected=Join-Path $env:SystemRoot 'Setup\KIZILELMA'
if ($PSScriptRoot -ine $expected) { throw 'KIZILELMA: hedef kurulum klasoru gerekli.' }
$os=Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
if ([Environment]::Is64BitOperatingSystem -or $os.CurrentBuildNumber -ne '14393' -or $os.EditionID -ne 'Core') { throw 'KIZILELMA: beklenmeyen Windows.' }
if ([Security.Principal.WindowsIdentity]::GetCurrent().User.Value -ne 'S-1-5-18' -or (Get-ItemProperty 'HKLM:\SYSTEM\Setup').SystemSetupInProgress -ne 1) { throw 'Windows Setup SYSTEM baglami gerekli.' }
function Put($Key,$Name,$Value,$Kind='DWord') {
 if (-not(Test-Path -LiteralPath $Key)) { New-Item -Path $Key -Force|Out-Null }
 New-ItemProperty -LiteralPath $Key -Name $Name -Value $Value -PropertyType $Kind -Force|Out-Null
}
$loaded=$false
Start-Transcript -Path (Join-Path $PSScriptRoot 'Machine.log') -Append|Out-Null
try {
 # KIZILELMA-1607-FrameworkCompatibility
 # The clean 14393 Home source stages these dependencies under Staged and beneath
 # application entries, not as standalone Applications. NTLite adds standalone
 # RequiresAllUserStoreRefresh entries; 14393 then removes them on first logon
 # under sideloading restrictions (AppX event 809). Preserve the clean structure.
 $frameworks=@('Microsoft.Advertising.Xaml_10.0.1605.0_x86__8wekyb3d8bbwe','Microsoft.NET.Native.Framework.1.3_1.3.23901.0_x86__8wekyb3d8bbwe','Microsoft.NET.Native.Runtime.1.3_1.3.23901.0_x86__8wekyb3d8bbwe','Microsoft.VCLibs.140.00_14.0.23816.0_x86__8wekyb3d8bbwe')
 foreach($framework in $frameworks){
  $key='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications\'+$framework
  if(Test-Path -LiteralPath $key){
   $entry=Get-ItemProperty -LiteralPath $key
   $expectedPath='%SYSTEMDRIVE%\Program Files\WindowsApps\'+$framework+'\AppxManifest.xml'
   if($entry.Path -ine $expectedPath -or $entry.RequiresAllUserStoreRefresh -ne 1){throw ('Beklenmeyen framework kaydi: '+$framework)}
   Remove-Item -LiteralPath $key -Recurse -Force
   Write-Output ('1607 temiz kaynak bagimlilik yapisi korundu: '+$framework)
  }
 }
 Put 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' 'NoAutoUpdate' 1
 Put 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' 'AllowCortana' 0
 Put 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' 'AllowGameDVR' 0
 Put 'HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack' 'Start' 4
 Set-Service wuauserv -StartupType Disabled
 Stop-Service wuauserv -ErrorAction Stop
 (Get-Service wuauserv).WaitForStatus('Stopped',[TimeSpan]::FromSeconds(40))
 # Home 1607 does not provide a supported automatic-update policy guarantee.
 # Keep all servicing files and provide an explicit user-operated service switch.
 $desktop=[Environment]::GetFolderPath('CommonDesktopDirectory')
 $shell=New-Object -ComObject WScript.Shell
 $shortcut=$shell.CreateShortcut((Join-Path $desktop 'KIZILELMA - Guncelleme yonetimi.lnk'))
 $shortcut.TargetPath=$env:SystemRoot+'\System32\WindowsPowerShell\v1.0\powershell.exe'
 $shortcut.Arguments='-NoProfile -ExecutionPolicy Bypass -File "'+$expected+'\Guncelleme-Yonetimi.ps1"'
 $shortcut.WorkingDirectory=$expected
 $shortcut.Description='Windows Update hizmetini isteginize gore acip kapatir.'
 $shortcut.Save()
 $default=[Environment]::ExpandEnvironmentVariables((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList').Default)
 & "$env:SystemRoot\System32\reg.exe" load 'HKU\KIZILELMA_Default' (Join-Path $default 'NTUSER.DAT')
 if($LASTEXITCODE -ne 0){throw 'Default kullanici kaydi acilamadi.'};$loaded=$true
 $root='Registry::HKEY_USERS\KIZILELMA_Default'
 $run='"'+$env:SystemRoot+'\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File "'+$expected+'\Initialize-User.ps1"'
 Put ($root+'\Software\Microsoft\Windows\CurrentVersion\RunOnce') '!KIZILELMAFirstLogon' $run 'String'
 Put ($root+'\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize') 'EnableTransparency' 0
 Put ($root+'\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced') 'TaskbarAnimations' 0
 Put ($root+'\Software\Microsoft\Windows\CurrentVersion\Search') 'SearchboxTaskbarMode' 1
 foreach($name in @('SilentInstalledAppsEnabled','SoftLandingEnabled','SystemPaneSuggestionsEnabled','PreInstalledAppsEnabled','OemPreInstalledAppsEnabled')){Put ($root+'\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager') $name 0}
 [GC]::Collect();[GC]::WaitForPendingFinalizers()
 & "$env:SystemRoot\System32\reg.exe" unload 'HKU\KIZILELMA_Default'
 if($LASTEXITCODE -ne 0){throw 'Default kullanici kaydi kaydedilemedi.'};$loaded=$false
 Put 'HKLM:\SOFTWARE\KIZILELMA' 'ProfileId' 'KIZILELMA-1607-x86-r1' 'String'
 Put 'HKLM:\SOFTWARE\KIZILELMA' 'DisplayName' 'Windows 10 KIZILELMA' 'String'
 Put 'HKLM:\SOFTWARE\KIZILELMA' 'MachineComplete' 1
 Write-Output 'KIZILELMA makine ayarlari tamamlandi.'
} finally {
 if($loaded){[GC]::Collect();[GC]::WaitForPendingFinalizers();& "$env:SystemRoot\System32\reg.exe" unload 'HKU\KIZILELMA_Default'}
 Stop-Transcript|Out-Null
}
