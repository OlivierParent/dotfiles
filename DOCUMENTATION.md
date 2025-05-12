# Documentation

*[TBD]: To be done

## See

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands)

## Installation

### Linux

TBD

### MacOS

TBD

### Windows

1. Go to [Microsoft Store](https://apps.microsoft.com/home) and get:
   1. [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701).
   2. [PowerShell](https://apps.microsoft.com/detail/9mz1snwt0n5d).
   3. [Visual Studio Code](https://apps.microsoft.com/detail/XP9KHM4BK9FZ7Q)
   4. Or use [`winget`](https://learn.microsoft.com/windows/package-manager/winget/).
      ```powershell
      PS > winget install 'Windows Terminal' PowerShell 'Visual Studio Code' --source msstore
      ```
3. Download and install the dotfiles from within PowerShell
   ```powershell
   PS > Set-Location $HOME
   PS > Invoke-WebRequest https://github.com/OlivierParent/dotfiles/archive/refs/heads/main.zip -OutFile dotfiles.zip
   PS > Expand-Archive .\dotfiles.zip .
   PS > Rename-Item .\dotfiles-main\ dotfiles
   PS > Set-Location dotfiles
   PS > .\install.ps1
   ```
