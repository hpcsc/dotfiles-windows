# David Nguyen's Windows dotfiles

An attempt to automate installation of essential softwares and settings for new Windows setup

## To backup VSCode extensions

```
code --list-extensions > vscode-extensions.txt
```

## For a new Windows setup

1. Install Git for Windows

    ```
    https://git-scm.com/download/win
    ```

2. Clone this repository
3. Open Powershell as Administrator, execute:

    ```
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```

4. Navigate to cloned directory, execute:

    ```
    .\bootstrap.ps1
    ```

5. Execute `.\power-settings.ps1` if this is laptop configuration

## Checklist after installation

- Jetbrains toolbox setup
- Import GPG key

## Optional Tools

### Windows Terminal

Execute `.\windows-terminal\setup.ps1` to copy settings.json to Windows Terminal settings location

### MultiCommander

- Download MultiCommander (portable version) and put it in a location that doesn't require admin permission, .e.g. `C:\tools\MultiCommander`
- Setup symlink to setting files

```
./MultiCommander/install.ps1 C:\tools\MultiCommander
```

- Pin MultiCommander to taskbar, modify `Target` in Properties to:

```
C:\tools\MultiCommander\MultiCommander.exe -F="C:\tools\MultiCommander\startup.ini" -AutoRun="Split 100/0"
```

This will open MultiCommander in 100/0 single split mode and at C:\ drive when starting up

### Shutdown script

Add shortcut to taskbar that points to `dotfiles-windows/shutdown/shutdown.cmd`
