$installLocation=$args[0]
Write-Host "Restoring MultiCommander ($installLocation) Settings..." -ForegroundColor "Yellow"

function BackUpAndSymlink($folderRelativePath, $fileName) {
    $folderAbsolutePath=Join-Path $installLocation $folderRelativePath
    $destinationFile=Join-Path $folderAbsolutePath $fileName
    if (Test-Path $destinationFile)
    {
        Rename-Item $destinationFile "$fileName.bk"
    }
    cmd /c mklink $destinationFile (Resolve-Path ".\MultiCommander\$folderRelativePath\$fileName").Path
}

BackUpAndSymlink "Config" "ExplorerPanel.xml"
BackUpAndSymlink "Config" "MultiCommander.xml"
BackUpAndSymlink "Config" "UserDefinedCommands.xml"
BackUpAndSymlink "Config" "CustomKeymappings.xml"
BackUpAndSymlink "Config" "MultiButtons.xml"
BackUpAndSymlink "SessionConfig\Config" "MultiCommander.ini"
