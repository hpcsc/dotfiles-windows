$relativeFilePath = "gitui\key_config.ron"
$destinationFile = Join-Path $env:APPDATA $relativeFilePath
if (Test-Path $destinationFile) {
    Remove-Item $destinationFile
}

cmd /c mklink $destinationFile (Resolve-Path $relativeFilePath).Path
