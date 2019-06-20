Add-Type -AssemblyName PresentationFramework
$result = [System.Windows.MessageBox]::Show("Are you sure you want to shut down the computer now?", "Shutting Down", [System.Windows.MessageBoxButton]::YesNo)
$yes = "Yes"
If($result -eq $yes)
{
    Stop-Computer
}
