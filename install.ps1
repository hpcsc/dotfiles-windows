# install Chocolatey
Set-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# essential software
choco install -y googlechrome firefox 7zip.install dropbox 1password vlc gom-player malwarebytes foxitreader

# development tools
choco install -y VisualStudioCode linqpad sourcetree docker-for-windows nvm conemu jetbrainstoolbox velocity boostnote

# restore vscode settings
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\settings.json") ".\vscode\settings.json"
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\keybindings.json") ".\vscode\keybindings.json"
cmd /c mklink /H (Join-Path $Env:programfiles "ConEmu\ConEmu.xml") ".\conemu\ConEmu.xml"
