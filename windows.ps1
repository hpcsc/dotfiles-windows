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

Write-Host "Mapping Capslock to LeftCtrl..." -ForegroundColor "Yellow"
$scancodeMapHexValue = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | ForEach-Object { "0x$_"}
$keyboardLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
New-ItemProperty -Path $keyboardLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$scancodeMapHexValue)
Remove-Variable scancodeMapHexValue
Remove-Variable keyboardLayout

Write-Host "Updating Windows Explorer Settings..." -ForegroundColor "Yellow"
$explorerAdvancedKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $explorerAdvancedKey LaunchTo 1            # Set "Open File Explorer to" to "This PC" instead of "Quick access"
Set-ItemProperty $explorerAdvancedKey Start_TrackDocs 0     # Turn off "Show recently opened items in Jump Lists on Start or the taskbar"
Set-ItemProperty $explorerAdvancedKey Start_TrackProgs 0    # Turn off "Show most used apps"
Set-ItemProperty $explorerAdvancedKey HideFileExt 0         # Turn off "Hide extensions for known file types"
Remove-Variable explorerAdvancedKey

$explorerKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer'
Set-ItemProperty $explorerKey ShowRecent 0                  # Disable "Show recent used files in Quick access"
Set-ItemProperty $explorerKey ShowFrequent 0                # Disable "Show frequently used folders in Quick access"
Remove-Variable explorerKey

Stop-Process -processname explorer
