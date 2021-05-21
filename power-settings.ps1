function Set-Buttons-Action() {
    $PowerButtonsAndLidSubGuid = "4f971e89-eebd-4455-a8de-9e59040e7347"

    $PowerButton = "7648efa3-dd9c-4e3e-b566-50f929386280"
    $PowerButtonValueIndex = 3 # 0 - Do nothing, 1 - Sleep, 2 - Hibernate, 3 - Shut down

    $CloseLidButton = "5ca83367-6e45-459f-a27b-476b1d01c936"
    $CloseLidValueIndex = 0 # 0 - Do nothing, 1 - Sleep, 2 - Hibernate, 3 - Shut down

    $Settings = @{}
    $Settings[$CloseLidButton] = $CloseLidValueIndex
    $Settings[$PowerButton] = $PowerButtonValueIndex

    $Settings.Keys | ForEach-Object {
        # Setting when plugged in
        powercfg /SetACValueIndex `
                SCHEME_CURRENT `
                $PowerButtonsAndLidSubGuid `
                $_ `
                $Settings.Item($_)

        # Setting when on battery
        powercfg /SetDCValueIndex `
                SCHEME_CURRENT `
                $PowerButtonsAndLidSubGuid `
                $_ `
                $Settings.Item($_)
    }

    Write-Host "Set button action" -Fore Green
}

function Set-Sleep-Timeout() {
    $PluggedInTimeOut = 60
    # when plugged in, PC goes to sleep after how many minues
    powercfg -change -standby-timeout-ac $PluggedInTimeOut
    Write-Host "Set sleep timeout to $PluggedInTimeOut minutes when plugged in" -Fore Green

    $BatteryTimeOut = 30
    # when on battery, PC goes to sleep after how many minues
    powercfg -change -standby-timeout-dc $BatteryTimeOut
    Write-Host "Set sleep timeout to $BatteryTimeOut minutes when on battery" -Fore Green
}

function Set-Monitor-Timeout() {
    $PluggedInTimeOut = 60
    # when plugged in, turn off screen after how many minues
    powercfg -change -monitor-timeout-ac $PluggedInTimeOut
    Write-Host "Set monitor timeout to $PluggedInTimeOut minutes when plugged in" -Fore Green

    $BatteryTimeOut = 30
    # when on battery, turn off screen after how many minues
    powercfg -change -monitor-timeout-dc $BatteryTimeOut
    Write-Host "Set monitor timeout to $BatteryTimeOut minutes when on battery" -Fore Green
}

function TurnOff-FastStartup() {
    # turn off fast startup - fast startup sometimes causes repeated restart
    powercfg /hibernate off
}


Set-Buttons-Action
Set-Sleep-Timeout
Set-Monitor-Timeout
TurnOff-FastStartup
powercfg -SetActive SCHEME_CURRENT
