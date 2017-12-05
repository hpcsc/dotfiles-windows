function PSAdmin() {
    Start-Process powershell "-NoExit", "-Command", "Set-Location $((Resolve-Path .\).Path)" -Verb runAs
}

function HyperAdmin() {
    As-Admin("hyper")
}

function As-Admin($processName) {
    Start-Process $processName -Verb runAs
}
