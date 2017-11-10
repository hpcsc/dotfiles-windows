# David Nguyen's Windows dotfiles

An attempt to automate installation of essential softwares and settings for new Windows setup

## To backup VSCode extensions

```
code --list-extensions > vscode-extensions
```

## For a new Windows setup

1. Install Git for Windows

    ```
    https://git-scm.com/download/win
    ```

2. Clone this repository
3. Open Powershell as Administrator, navigate to cloned directory, execute:

    ```
    .\bootstrap.ps1
    ```
4. Install `IntelliJ`, `Rider` using `Jetbrains Toolbox` and import settings manually from `Jetbrains` folder
