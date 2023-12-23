$Installer = "c:\windows\temp\gsync_enterprise64.msi"
$url = "https://dl.google.com/drive/gsync_enterprise64.msi"
Invoke-WebRequest -Uri $url -OutFile $Installer -UseBasicParsing
Start-Process -FilePath $Installer -Args '/quiet /qn /norestart /lex backupandsyncmsi.log ' -Wait
Remove-Item -Path $Installer