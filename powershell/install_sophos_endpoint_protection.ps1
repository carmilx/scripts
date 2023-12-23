$Installer = "c:\windows\temp\SophosSetup.exe"
$url = "api_url"
Invoke-WebRequest -Uri $url -OutFile $Installer -UseBasicParsing
Start-Process -FilePath $Installer -Args '--products=antivirus --quiet' -Wait
Remove-Item -Path $Installer