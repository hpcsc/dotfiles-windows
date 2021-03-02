# these functions relies on PSFzf: https://github.com/kelleyma49/PSFzf

function fsb() {
    $selected = git branch -a --list --format='%(refname:short)' --ignore-case "*${args}*" | `
                    Where-Object { $_ -NotMatch "HEAD" } | `
                    Invoke-Fzf -Select1 -Exit0 -Layout reverse
    $escaped = ($selected -replace '[^a-zA-Z0-9 -_]').Trim()

    if ([string]::IsNullOrWhitespace($escaped)) {
        Write-Host "No branch matches the provided pattern" -Foreground Yellow
    } else {
        git checkout $escaped.Substring($escaped.LastIndexOf('/') + 1)
    }
}

function frb() {
    $selected = git branch --list --format='%(refname:short)' --ignore-case "*${args}*" | `
                    Invoke-Fzf -Multi -Exit0 -Layout reverse

    if ([string]::IsNullOrWhitespace($selected)) {
        Write-Host "No branch selected or no branch matches the provided pattern" -Foreground Yellow
    } else {
        $selected.Split(' ') | ForEach-Object {
            git branch -D $_
        }
    }
}

function fdrm() {
    $selected = docker ps -a --format '{{.Names}}' | `
                    Invoke-Fzf -Multi -Exit0 -Layout reverse -Preview "docker ps -a -f `"name={}`"" -PreviewWindow "down:30%"

    if ([string]::IsNullOrWhitespace($selected)) {
        Write-Host "No container selected" -Foreground Yellow
    } else {
        $selected.Split(' ') | ForEach-Object {
            docker container rm $_
        }
    }
}

function fdirm() {
    $danglingImages = docker images -f "dangling=true" -q
    if (! [string]::IsNullOrWhitespace($danglingImages)) {
        docker image rm $danglingImages
    }

    $selected = docker images --format '{{.Repository}}:{{.Tag}}' | `
                    Invoke-Fzf -Multi -Exit0 -Layout reverse -Preview "docker images --filter `"reference={}`"" -PreviewWindow "down:30%"

    if ([string]::IsNullOrWhitespace($selected)) {
        Write-Host "No image selected" -Foreground Yellow
    } else {
        $selected.Split(' ') | ForEach-Object {
            docker image rm $_
        }
    }
}

function fcm() {
    if ([string]::IsNullOrWhiteSpace(${args})) {
        Write-Host "Commit message is required" -Foreground Red
        return
    }

    $coauthorsFilePath = "$HOME\.git-co-authors"
    if (! (Test-Path $coauthorsFilePath)) {
        Write-Host "File $coauthorsFilePath does not exist" -Foreground Red
        return
    }

    $selected = Get-Content $coauthorsFilePath |
            fzf -m --layout=reverse |
            ForEach-Object {
                "co-authored-by: $_"
            }

    if ($selected.Length -eq 0) {
        Write-Host "No coauthor selected" -Foreground Red
        return
    }

    $coauthorsMessage = $selected -join "`n"
    git commit -m "${args}`n`n${coauthorsMessage}"
}
