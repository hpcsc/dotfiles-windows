Write-Host "Enabling Windows Features..." -ForegroundColor "Yellow"
Enable-WindowsOptionalFeature -Online -All -FeatureName `
"Microsoft-Hyper-V", `
"Containers", `
"Microsoft-Windows-Subsystem-Linux"`
-NoRestart

$storeAppsToRemove = "Microsoft.BingNews", "Microsoft.BingFinance", "Microsoft.BingSports", "Microsoft.BingWeather", "Microsoft.MicrosoftOfficeHub", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo"
$storeAppsToRemove += "king.com.CandyCrushSodaSaga", "Facebook.Facebook"
Write-Host "Removing following Store Apps: "$storeAppsToRemove -ForegroundColor "Yellow"

Get-AppxPackage  -AllUsers | Where-Object Name -in $storeAppsToRemove | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where-Object DisplayName -in $storeAppsToRemove | Remove-AppxProvisionedPackage -Online

Remove-Variable storeAppsToRemove