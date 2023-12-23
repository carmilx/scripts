$Installer = "$env:temp\chrome_installer.exe"
$url = 'http://dl.google.com/chrome/chrome_installer.exe'
Invoke-WebRequest -Uri $url -OutFile $Installer -UseBasicParsing
Start-Process -FilePath $Installer -Args '/silent /install' -Wait
Remove-Item -Path $Installer