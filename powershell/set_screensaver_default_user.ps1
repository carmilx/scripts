# set screensaver settings for default user

REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT

# Set ScreenSaver Default user
If (!(Test-Path -Path "HKLM:\Default\Control Panel\Desktop")) { New-Item "HKLM:\Default\Control Panel\Desktop" }
# screensaver effect
Set-ItemProperty -Path "HKLM:\Default\Control Panel\Desktop" -Name "SCRNSAVE.EXE" -Value "C:\Windows\system32\Ribbons.scr" -Type STRING -Force
# screensaver timeout period in seconds
Set-ItemProperty -Path "HKLM:\Default\Control Panel\Desktop" -Name "ScreenSaveTimeout" -Value "2400" -Type STRING -Force
# lock computer
Set-ItemProperty -Path "HKLM:\Default\Control Panel\Desktop" -Name "ScreenSaverIsSecure" -Value "1" -Type STRING -Force

# Unload default user hive
$unloaded = $false
$attempts = 0
while (!$unloaded -and ($attempts -le 5))
{
	0
	[gc]::Collect() # necessary call to be able to unload registry hive
	REG UNLOAD HKLM\DEFAULT
	$unloaded = $?
	$attempts += 1
}
if (!$unloaded)
{
	Write-Warning "Unable to dismount default user registry hive at HKLM\DEFAULT - manual dismount required"
}