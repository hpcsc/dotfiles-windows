Write-Host "Restoring Visual Studio Code Settings..." -ForegroundColor "Yellow"
New-Item -Path (Join-Path $Env:APPDATA "Code\User") -ItemType directory -Force

if (!(Test-Path (Join-Path $Env:APPDATA "Code\User\settings.json") -PathType Leaf))
{
        cmd /c mklink (Join-Path $Env:APPDATA "Code\User\settings.json") (Resolve-Path ".\vscode\settings.json").Path
}

if (!(Test-Path (Join-Path $Env:APPDATA "Code\User\keybindings.json") -PathType Leaf))
{
        cmd /c mklink (Join-Path $Env:APPDATA "Code\User\keybindings.json") (Resolve-Path ".\vscode\keybindings.json").Path
}

Write-Host "Installing Visual Studio Code Extensions..." -ForegroundColor "Yellow"
Get-Content ./vscode-extensions.txt | Foreach-Object { code --install-extension $_ }
Write-Host "Uninstalling Visual Studio Code Extensions that are not in the list..." -ForegroundColor "Yellow"
Compare-Object -ReferenceObject (code --list-extensions) `
               -DifferenceObject (Get-Content ./vscode-extensions.txt) `
               -PassThru | `
        Where-Object { $_.SideIndicator -eq '<=' } | `
        ForEach-Object { code --uninstall-extension $_ }

if (!(Test-Path (Join-Path $Env:USERPROFILE ".gitconfig") -PathType Leaf))
{
        Write-Host "Restoring gitconfig..." -ForegroundColor "Yellow"
        cmd /c mklink (Join-Path $Env:USERPROFILE ".gitconfig") (Resolve-Path ".\git\.gitconfig").Path
}

Write-Host "Restoring Hyper Settings..." -ForegroundColor "Yellow"
if (!(Test-Path (Join-Path $Env:USERPROFILE ".hyper.js") -PathType Leaf))
{
        cmd /c mklink (Join-Path $Env:USERPROFILE ".hyper.js") (Resolve-Path ".\hyper\.hyper.js").Path
}

Write-Host "Add Hyper to User Path Variable..." -ForegroundColor "Yellow"
. (Resolve-Path ".\powershell\misc.ps1").Path
Update-User-Variable (Join-Path $Env:LOCALAPPDATA "hyper")

# Create context menu to open Hyper when right clicking any folder
# New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR # create new drive for registry HKEY_CLASSES_ROOT
# Push-Location # save current path
# Set-Location HKCR:
# if (!(Test-Path "Directory/Background/Shell/ConEmu Here")) {
#     New-Item -Path "Directory/Background/Shell" -Name "ConEmu Here"
#     New-Item -Path "Directory/Background/Shell/ConEmu Here/command" -Value "`"C:\\Program Files\\ConEmu\\ConEmu64.exe`" -Dir %V"
# }
# Pop-Location # restore to previous path

if (!(File-Contains-Text $PROFILE "custom functions"))
{
        Write-Host "Updating Powershell Profile..." -ForegroundColor "Yellow"
        $powershellFolder = (Resolve-Path ".\powershell").Path
        Add-Content $PROFILE "# Loading custom functions"
        Add-Content $PROFILE "Get-ChildItem `"$powershellFolder\*.ps1`" | %{.`$_}"
}
