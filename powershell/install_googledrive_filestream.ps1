$Installer = "c:\windows\temp\GoogleDriveFSSetup.exe"
$url = "https://dl.google.com/drive-file-stream/GoogleDriveFSSetup.exe"
Invoke-WebRequest -Uri $url -OutFile $Installer -UseBasicParsing
Start-Process -FilePath $Installer -Args '--silent --desktop_shortcut' -Wait
Remove-Item -Path $Installer