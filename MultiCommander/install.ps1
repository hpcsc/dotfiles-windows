$installLocation=$args[0]
Write-Host "Restoring MultiCommander ($installLocation) Settings..." -ForegroundColor "Yellow"

function BackUpAndSymlink($folderRelativePath, $fileName) {
    $folderAbsolutePath=Join-Path $installLocation $folderRelativePath
    $destinationFile=Join-Path $folderAbsolutePath $fileName
    Write-Host $destinationFile
    if (Test-Path $destinationFile)
    {
        Write-Host "$destinationFile exists, renaming existing file to $fileName.bk" -ForegroundColor "Yellow"
        $backUpFile=Join-Path $folderAbsolutePath "$fileName.bk"
        if (Test-Path $backUpFile)
        {
            Write-Host "$backUpFile exists, deleting" -ForegroundColor "Yellow"
            Remove-Item $backUpFile
        }
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
BackUpAndSymlink "" "startup.ini"
