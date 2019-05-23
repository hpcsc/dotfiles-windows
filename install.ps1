if (Get-Command choco -errorAction SilentlyContinue)
{
    Write-Host "Upgrading Chocolatey..." -ForegroundColor "Yellow"
    choco upgrade -y chocolatey
}
else
{
    Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"
    Set-ExecutionPolicy Bypass; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco feature enable -n=allowGlobalConfirmation
}

Write-Host "Installing essential softwares..." -ForegroundColor "Yellow"
choco install googlechrome firefox 7zip.install dropbox 1password vlc malwarebytes foxitreader authy-desktop greenshot

Write-Host "Installing development tools..." -ForegroundColor "Yellow"
choco install VisualStudioCode linqpad docker-for-windows dotnetcore-sdk nvm jetbrainstoolbox velocity boostnote jdk8 hyper

refreshenv
