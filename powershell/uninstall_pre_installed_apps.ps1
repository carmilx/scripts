# Remove 'Get Help' app aka QuickAssist functionality
Write-Host "Uninstalling 'Get Help' app"
Get-WindowsCapability -online | ? { $_.Name -like '*QuickAssist*' } | Remove-WindowsCapability –online | Out-Null

# Remove 'Contact Support' app
Write-Host "Uninstalling 'Contact Support' app"
Get-WindowsCapability -online | ? { $_.Name -like '*ContactSupport*' } | Remove-WindowsCapability –online | Out-Null

# ---------------------------------------------------------------------
# This function removes unwanted Apps that come with Windows
# List apps
$apps = @(
	# Microsoft apps
	"Microsoft.3DBuilder"
	"Microsoft.DesktopAppInstaller"
	"Microsoft.Print3D"
	"Microsoft.Microsoft3DViewer"
	"Microsoft.MSPaint"
	"Microsoft.WindowsFeedbackHub"
	"Microsoft.Appconnector"
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	"Microsoft.BingFoodAndDrink"
	"Microsoft.BingTravel"
	"Microsoft.BingHealthAndFitness"
	"Microsoft.WindowsReadingList"
	"Microsoft.GetHelp"
	"Microsoft.Getstarted"
	"Microsoft.Messaging"
	"Microsoft.MicrosoftOfficeHub"
	"Microsoft.MicrosoftSolitaireCollection"
	"Microsoft.Office.OneNote"
	"Microsoft.People"
	"Microsoft.SkypeApp"
	#"Microsoft.Windows.Photos"
	"Microsoft.WindowsAlarms"
	#"Microsoft.WindowsCalculator"
	#"Microsoft.WindowsCamera"
	"Microsoft.WindowsMaps"
	"Microsoft.WindowsPhone"
	"Microsoft.WindowsSoundRecorder"
	"Microsoft.WindowsMaps"
	#"Microsoft.WindowsStore"
	"Microsoft.XboxApp"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.Xbox.TCUI"
	"Microsoft.XboxGameOverlay"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"microsoft.windowscommunicationsapps"
	"Microsoft.MinecraftUWP"
	"Microsoft.OneConnect"
	"Microsoft.WindowsFeedbackHub"
	"Microsoft.CommsPhone"
	"Microsoft.ConnectivityStore"
	"Microsoft.Messaging"
	"Microsoft.Office.Sway"
	"Microsoft.NetworkSpeedTest"
	"Microsoft.Wallet"

	# non-Microsoft
	"9E2F88E3.Twitter"
	"PandoraMediaInc.29680B314EFC2"
	"Flipboard.Flipboard"
	"ShazamEntertainmentLtd.Shazam"
	"king.com.CandyCrushSaga"
	"king.com.CandyCrushSodaSaga"
	"king.com.*"
	"ClearChannelRadioDigital.iHeartRadio"
	"4DF9E0F8.Netflix"
	"6Wunderkinder.Wunderlist"
	"Drawboard.DrawboardPDF"
	"2FE3CB00.PicsArt-PhotoStudio"
	"D52A8D61.FarmVille2CountryEscape"
	"TuneIn.TuneInRadio"
	"GAMELOFTSA.Asphalt8Airborne"
	"TheNewYorkTimes.NYTCrossword"
	"DB6EA5DB.CyberLinkMediaSuiteEssentials"
	"Facebook.Facebook"
	"flaregamesGmbH.RoyalRevolt2"
	"Playtika.CaesarsSlotsFreeCasino"
	"A278AB0D.MarchofEmpires"
	"KeeperSecurityInc.Keeper"
	"ThumbmunkeysLtd.PhototasticCollage"
	"XINGAG.XING"
	"89006A2E.AutodeskSketchBook"
	"D5EA27B7.Duolingo-LearnLanguagesforFree"
	"46928bounde.EclipseManager"
	"ActiproSoftwareLLC.562882FEEB491"
)

# Uninstall apps
foreach ($app in $apps)
{
	Write-Host "Uninstalling $app"

	Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage | Out-Null

	Get-AppXProvisionedPackage -Online |
	where DisplayName -EQ $app |
	Remove-AppxProvisionedPackage -Online | Out-Null
}
