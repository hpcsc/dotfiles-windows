# install Chocolatey
Set-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n=allowGlobalConfirmation

# essential software
choco install googlechrome firefox 7zip.install dropbox 1password vlc malwarebytes foxitreader

# development tools
choco install VisualStudioCode linqpad sourcetree docker-for-windows nvm conemu jetbrainstoolbox velocity boostnote jdk8

# restore vscode settings
New-Item -Path (Join-Path $Env:APPDATA "Code\User") -ItemType directory -Force
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\settings.json") ".\vscode\settings.json"
cmd /c mklink /H (Join-Path $Env:APPDATA "Code\User\keybindings.json") ".\vscode\keybindings.json"
cmd /c mklink /H (Join-Path $Env:programfiles "ConEmu\ConEmu.xml") ".\conemu\ConEmu.xml"
