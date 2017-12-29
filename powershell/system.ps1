function Enable-VerboseStatusMessage()
{
    # To enable Windows Verbose Status Message during startup/shutdown/login/logoff operations
    # May increase startup/shutdown time so not recommended to turn on permanently
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'verbosestatus' -Value 1
}

function Disable-VerboseStatusMessage()
{
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'verbosestatus' -Value 0
}
