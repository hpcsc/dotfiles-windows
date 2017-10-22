Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"
Set-ExecutionPolicy Bypass; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n=allowGlobalConfirmation

Write-Host "Installing essential softwares..." -ForegroundColor "Yellow"
choco install googlechrome firefox 7zip.install dropbox 1password vlc malwarebytes foxitreader

Write-Host "Installing development tools..." -ForegroundColor "Yellow"
choco install VisualStudioCode linqpad sourcetree docker-for-windows dotnetcore-sdk nvm conemu jetbrainstoolbox velocity boostnote jdk8