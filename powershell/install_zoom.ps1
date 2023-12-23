$Installer = "C:\Windows\temp\ZoomInstallerFull.msi"
$url = 'https://www.zoom.us/client/latest/ZoomInstallerFull.msi'
Invoke-WebRequest -Uri $url -OutFile $Installer -UseBasicParsing
Start-Process -FilePath $Installer -Args '/quiet /qn /norestart /lex zoommsi.log ZoomAutoUpdate="true" ZSSOHOST="https://domain.zoom.us"' -Wait
Remove-Item -Path $Installer