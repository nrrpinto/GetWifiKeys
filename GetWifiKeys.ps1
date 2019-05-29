<#
.SYNOPSIS

  This is a small part of a bigger forensic tool, the Inquisitor. It occurred to me to isolate it as a quick script to get the Wifi preshared connection keys.

.DESCRIPTION
  
  Script to retrieve the Wifi keys. It works only with pre-shared key Wifi networks.

.EXAMPLE

	GetWifiKeys.ps1

.NOTES

  Author:  f4d0
  Last Updated: 2019.05.29
  f4d0.eu

#>

cmd.exe /c netsh wlan show profiles > "$Global:Destiny\$HOSTNAME\NetworkWIFI\WifiProfiles.txt"
cmd.exe /c netsh wlan show all > "$Global:Destiny\$HOSTNAME\Network\WIFI_Profiles_Configuration.txt"
cmd.exe /c netsh wlan export profile folder=$Global:Destiny\$HOSTNAME\WIFI\ > $null

cmd.exe /c netsh wlan show profiles | Select-String "All User Profile" | ForEach {
  $bla = netsh wlan show profiles name=$(($_ -split ":")[1].Trim()) key="clear"
  $SSID = ((($bla | Select-String "SSID Name") -split ":")[1].Trim())
  $KEY = ((($bla | Select-string "Key Content") -split ":")[1].Trim())
  Write-Host "SSID: $SSID | Key: $KEY" -ForegroundColor Green
}
