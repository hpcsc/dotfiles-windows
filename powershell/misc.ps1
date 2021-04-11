function PSAdmin() {
    Start-Process powershell "-NoExit", "-Command", "Set-Location $((Resolve-Path .\).Path)" -Verb runAs
}

function As-Admin($processName) {
    Start-Process $processName -WindowStyle hidden -Verb runAs
}

function Update-User-Variable($value) {
    $key = "Path"
    $currentValue = Get-User-Variable($key)
    $splitted = $currentValue.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
    Write-Host "[Path]: $currentValue" -ForegroundColor "Yellow"
    If ($splitted.Contains($value)) {
        Write-Host "Value [$value] exists, skip appending" -ForegroundColor "Yellow"
    }
    Else {
        $splitted += $value
        [Environment]::SetEnvironmentVariable($key, ($splitted -join ';'), [System.EnvironmentVariableTarget]::User)
        Write-Host "[Path]: $(Get-User-Variable($key))" -ForegroundColor "Yellow"
    }
}

function Get-User-Variable($key) {
    [Environment]::GetEnvironmentVariable($key, [System.EnvironmentVariableTarget]::User)
}

function File-Contains-Text($filePath, $text) {
    if (!(Test-Path $filePath)) {
        return $false
    }

    $file = Get-Content $filePath
    $containsWord = $file | % { $_ -match $text }
    return ($containsWord -contains $true)
}

$EscapeCharacter = [char]27
$BeginningOfColorText = "[38;2;"
$ArrowSymbol = [char]::ConvertFromUtf32(0x276F)
function prompt() {
    $currentGitBranch = git rev-parse --abbrev-ref HEAD
    $gitPrompt = if ([string]::IsNullOrWhiteSpace($currentGitBranch)) {
        ""
    }
    else {
        " $(Get-ColorText "105;245;66" "[$currentGitBranch]")"
    }
    $arrows = "$(Get-ColorArrow("245;78;66"))$(Get-ColorArrow("245;120;66"))$(Get-ColorArrow("105;245;66"))"
    "$($executionContext.SessionState.Path.CurrentLocation)$gitPrompt $arrows "
}

function Get-ColorArrow(
    $ColorInRGB
) {
    Get-ColorText $ColorInRGB $ArrowSymbol
}

function Get-ColorText(
    $ColorInRGB,
    $Text
) {
    "${EscapeCharacter}${BeginningOfColorText}${ColorInRGB}m${Text}${EscapeCharacter}[0m"
}

function Load-Env() {
    Get-Content .\.env | Where-Object { ![string]::IsNullOrWhiteSpace($_) } | ForEach-Object {
        $splitted = $_.Split("=")
        [Environment]::SetEnvironmentVariable($splitted[0], $splitted[1], [System.EnvironmentVariableTarget]::Process)
        Write-Host "Set environment variable $(${splitted}[0])" -Fore Green
    }
}

function gbls() {
    git branch --format='%(refname:short)' |
    Select-Object @{ Name = "Branch"; Expression = { $_ } },
    @{ Name = "Description"; Expression = { git config "branch.$_.description" | Out-String } }
}

function batect-here() {
    (Invoke-WebRequest https://api.github.com/repos/batect/batect/releases/latest | ConvertFrom-Json).assets |
    Where-Object { $_.name -eq "batect" -or $_.name -eq "batect.cmd" } |
    Select-Object @{ Name = "Url"; Expression = { $_.browser_download_url } },
    @{ Name = "Name"; Expression = { $_.name } } |
    ForEach-Object { Invoke-WebRequest $_.Url -OutFile $_.Name }

    @"
project_name: $((Get-Item -Path .).BaseName)

containers:
  withBuildDirectory:
    build_directory: .
    volumes:
      - local: .
        container: /app
        options: cached
    working_directory: /app

  withImage:
    image: some-image
    volumes:
      - local: .
        container: /app
        options: cached
    working_directory: /app

tasks:
  sampleTask:
    description: some description
    run:
      container: withImage
      command: some-command
"@ | Set-Content ./batect.yml

    @"
# Shell scripts require LF
*.sh    text eol=lf
# Batch scripts require CRLF
*.bat   text eol=crlf
*.cmd   text eol=crlf
"@ | Set-Content ./.gitattributes
}
