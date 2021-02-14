function fsb() {
    # this function relies on PSFzf: https://github.com/kelleyma49/PSFzf
    $selected = git branch -a --list --format='%(refname:short)' --ignore-case "*${args}*" | `
                    Where-Object { $_ -NotMatch "HEAD" } | `
                    Invoke-Fzf -Select1 -Exit0
    $escaped = ($selected -replace '[^a-zA-Z0-9 -_]').Trim()

    if ([string]::IsNullOrWhitespace($escaped)) {
        Write-Host "No branch matches the provided pattern" -Foreground Yellow
    } else {
        git checkout $escaped.Substring($escaped.LastIndexOf('/') + 1)
    }
}
