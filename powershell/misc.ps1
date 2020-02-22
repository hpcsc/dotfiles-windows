function PSAdmin() {
    Start-Process powershell "-NoExit", "-Command", "Set-Location $((Resolve-Path .\).Path)" -Verb runAs
}

function HyperAdmin() {
    As-Admin("hyper")
}

function As-Admin($processName) {
    Start-Process $processName -WindowStyle hidden -Verb runAs
}

function Update-User-Variable($value) {
    $key="Path"
    $currentValue=Get-User-Variable($key)
    $splitted = $currentValue.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
    Write-Host "[Path]: $currentValue" -ForegroundColor "Yellow"
    If($splitted.Contains($value))
    {
        Write-Host "Value [$value] exists, skip appending" -ForegroundColor "Yellow"
    }
    Else
    {
        $splitted += $value
        [Environment]::SetEnvironmentVariable($key, ($splitted -join ';'), [System.EnvironmentVariableTarget]::User)
        Write-Host "[Path]: $(Get-User-Variable($key))" -ForegroundColor "Yellow"
    }
}

function Get-User-Variable($key) {
    [Environment]::GetEnvironmentVariable($key, [System.EnvironmentVariableTarget]::User)
}

function File-Contains-Text($filePath, $text)
{
    if (!(Test-Path $filePath))
    {
        return $false
    }

    $file = Get-Content $filePath
    $containsWord = $file | %{$_ -match $text}
    return ($containsWord -contains $true)
}

$EscapeCharacter = [char]27
$BeginningOfColorText = "[38;2;"
$ArrowSymbol = [char]::ConvertFromUtf32(0x276F)
function prompt()
{
  "$($executionContext.SessionState.Path.CurrentLocation) $(Get-ColorArrow("245;78;66"))$(Get-ColorArrow("245;120;66"))$(Get-ColorArrow("105;245;66"))${EscapeCharacter}[0m "
}


function Get-ColorArrow(
    $ColorInRGB
)
{
    "${EscapeCharacter}${BeginningOfColorText}${ColorInRGB}m${ArrowSymbol}"
}
