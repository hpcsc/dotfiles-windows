Write-Host "Restoring Vim/NeoVim Settings..." -ForegroundColor "Yellow"
$nvimLocalAppData = Join-Path $Env:LOCALAPPDATA "nvim"
if (!(Test-Path $nvimLocalAppData)) {
    Write-Host "Creating $nvimLocalAppData" -ForegroundColor "Green"
    mkdir $nvimLocalAppData
}

$autoloadPath = Join-Path $nvimLocalAppData "autoload"
if (!(Test-Path $autoloadPath)) {
    Write-Host "Creating symlink for $autoloadPath" -ForegroundColor "Green"
    New-Item -ItemType SymbolicLink -Path $autoloadPath -Target (Resolve-Path ".\vim\autoload").Path
}

$initVimPath = Join-Path $nvimLocalAppData "init.vim"
if (!(Test-Path $initVimPath)) {
    Write-Host "Creating symlink for $initVimPath" -ForegroundColor "Green"
    New-Item -ItemType SymbolicLink -Path $initVimPath -Target (Resolve-Path ".\vim\init.vim").Path
}

$vimSettingFiles = (".ideavimrc", ".keybindings.vim", ".vimrc")
$vimSettingFiles | ForEach-Object {
    $file = Join-Path $HOME $_
    if (!(Test-Path $file)) {
        Write-Host "Creating symlink for $file" -ForegroundColor "Green"
        New-Item -ItemType SymbolicLink -Path $file -Target (Resolve-Path ".\vim\$_").Path
    }
}

nvim +PlugInstall +UpdateRemotePlugins +qall
