function fsb() {
    # this function relies on PSFzf: https://github.com/kelleyma49/PSFzf
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
    # this function relies on PSFzf: https://github.com/kelleyma49/PSFzf
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
