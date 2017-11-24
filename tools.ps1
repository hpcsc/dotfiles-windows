Write-Host "Restoring Visual Studio Code Settings..." -ForegroundColor "Yellow"
New-Item -Path (Join-Path $Env:APPDATA "Code\User") -ItemType directory -Force
cmd /c mklink (Join-Path $Env:APPDATA "Code\User\settings.json") (Resolve-Path ".\vscode\settings.json").Path
cmd /c mklink (Join-Path $Env:APPDATA "Code\User\keybindings.json") (Resolve-Path ".\vscode\keybindings.json").Path

Write-Host "Installing Visual Studio Code Extensions..." -ForegroundColor "Yellow"
Get-Content ./vscode-extensions.txt | Foreach-Object { code --install-extension $_ }

Write-Host "Restoring gitconfig..." -ForegroundColor "Yellow"
cmd /c mklink (Join-Path $Env:USERPROFILE ".gitconfig") (Resolve-Path ".\git\.gitconfig").Path

Write-Host "Restoring ConEmu Settings..." -ForegroundColor "Yellow"
cmd /c mklink /H (Join-Path $Env:programfiles "ConEmu\ConEmu.xml") (Resolve-Path ".\conemu\ConEmu.xml").Path
# Create context menu to open ConEmu when right clicking any folder
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR # create new drive for registry HKEY_CLASSES_ROOT
Push-Location # save current path
Set-Location HKCR:
if (!Test-Path "Directory/Background/Shell/ConEmu Here") {
    New-Item -Path "Directory/Background/Shell" -Name "ConEmu Here"
    New-Item -Path "Directory/Background/Shell/ConEmu Here/command" -Value "`"C:\\Program Files\\ConEmu\\ConEmu64.exe`" -Dir %V"
}
Pop-Location # restore to previous path

Write-Host "Updating Powershell Profile..." -ForegroundColor "Yellow"
$powershellFolder = (Resolve-Path ".\powershell").Path
Add-Content $PROFILE "# Loading custom functions"
Add-Content $PROFILE "Get-ChildItem `"$powershellFolder\*.ps1`" | %{.`$_}"
