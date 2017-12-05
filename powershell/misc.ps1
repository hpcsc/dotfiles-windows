function PSAdmin() {
    As-Admin("powershell")
}

function HyperAdmin() {
    As-Admin("hyper")
}

function As-Admin($processName) {
    Start-Process $processName -Verb runAs
}
