# Rule name
$rules = @(
	# 
	"Remote Desktop"
	"Remote Event Log Management"
	"File and Printer Sharing (Echo Request - ICMPv4-In)"
	"File and Printer Sharing (Echo Request - ICMPv6-In)"
	"Remote Event Log Management (RPC)"
	"Remote Event Log Management (NP-In)"
	"Remote Event Log Management (RPC-EPMAP)"
	"Windows Management Instrumentation (WMI)"
	"Windows Management Instrumentation (DCOM-In)"
	"Windows Management Instrumentation (ASync-In)"
)

# set rules
foreach ($rule in $rules)
{
	Write-Host "Setting Firewall Rule $rule"
	Get-NetFirewallRule | Where {$_.DisplayName -eq $rule -and $_.Profile -eq "Domain"} | Enable-NetFirewallRule

}