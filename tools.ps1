Write-Host "Restoring Visual Studio Code Settings..." -ForegroundColor "Yellow"
New-Item -Path (Join-Path $Env:APPDATA "Code\User") -ItemType directory -Force
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\settings.json") ".\vscode\settings.json"
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\keybindings.json") ".\vscode\keybindings.json"

Write-Host "Restoring ConEmu Settings..." -ForegroundColor "Yellow"
cmd /c mklink /H (Join-Path $Env:programfiles "ConEmu\ConEmu.xml") ".\conemu\ConEmu.xml"

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All