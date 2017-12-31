$installLocation=$args[0]
Write-Host "Restoring MultiCommander ($installLocation) Settings..." -ForegroundColor "Yellow"

function BackUpAndSymlink($folderRelativePath, $fileName) {
    $folderAbsolutePath=Join-Path $installLocation $folderRelativePath
    Rename-Item (Join-Path $folderAbsolutePath $fileName) "$fileName.bk"
    cmd /c mklink (Join-Path $folderAbsolutePath $fileName) (Resolve-Path ".\MultiCommander\$folderRelativePath\$fileName").Path
}

BackUpAndSymlink "Config" "ExplorerPanel.xml"
BackUpAndSymlink "Config" "MultiCommander.xml"
BackUpAndSymlink "Config" "UserDefinedCommands.xml"
BackUpAndSymlink "SessionConfig\Config" "MultiCommander.ini"
