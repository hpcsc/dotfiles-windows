Write-Host "Restoring Visual Studio Code Settings..." -ForegroundColor "Yellow"
New-Item -Path (Join-Path $Env:APPDATA "Code\User") -ItemType directory -Force
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\settings.json") ".\vscode\settings.json"
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\keybindings.json") ".\vscode\keybindings.json"

Write-Host "Installing Visual Studio Code Extensions..." -ForegroundColor "Yellow"
Get-Content ./vscode-extensions | Foreach-Object { code --install-extension $_ }

Write-Host "Restoring ConEmu Settings..." -ForegroundColor "Yellow"
cmd /c mklink /H (Join-Path $Env:programfiles "ConEmu\ConEmu.xml") ".\conemu\ConEmu.xml"