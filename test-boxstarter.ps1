Disable-UAC

####################################
#   Eliminación de Aplicaciones.   #
####################################

function removeApp {
	Param ([string]$appRemove)
	Write-Output "Trying to remove $appRemove"
	Get-AppxPackage $appRemove -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayNam -like $appRemove | Remove-AppxProvisionedPackage -Online
}

$applicationListRemove = @(
	"*Facebook*"
	"*Keeper*"
	"*Netflix*"
	"*Twitter*"
	"*xbox*"
	"*king*"
	"*3D*"
	"*Skype*"
	"*office*"
	"*dropbox*"	
);

foreach ($app in $applicationListRemove) {
    removeApp $app
}

####################################
#     Configuracion de equipo.     #
####################################

rename-computer -NewName MORENO
#add-computer -WorkGroupName ACTSIS -DomainName actsis.com -Credentials ACTSIS\daniel.quiroz
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name ProfilesDirectory -Value G:\usuarios -type EXPAND
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name LaunchTo -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt  -Value 0 -Type DWORD
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden  -Value 1 -Type DWORD

####################################
#     Instalacion de software.     #
####################################

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

function AddApp {
	Param ([string]$appAdd)
	cinst $appAdd
}

$applicationListAdd = @(
	"wps-office-free"
    "notepadplusplus"
    "firefox"
	"googlechrome"
	"7zip"
);

foreach ($app in $applicationListAdd) {
	AddApp $app
}

Enable-UAC
