# install Chocolatey
Set-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# essential software
choco install -y googlechrome firefox 7zip.install dropbox 1password vlc gom-player malwarebytes

# development tools
choco install -y VisualStudioCode linqpad sourcetree docker-for-windows nodejs.install conemu

# restore vscode settings
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\settings.json") ".\vscode\settings.json"
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\keybindings.json") ".\vscode\keybindings.json"