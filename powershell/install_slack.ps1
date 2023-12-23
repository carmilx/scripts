$Installer = "C:\Windows\temp\slack_installer.msi"
$url = 'https://slack.com/ssb/download-win64-msi/'
Invoke-WebRequest -Uri $url -OutFile $Installer -UseBasicParsing
Start-Process -FilePath $Installer -Args '/qn' -Wait
Remove-Item -Path $Installer