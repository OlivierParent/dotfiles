# PowerShell
# ==========
# https://learn.microsoft.com/powershell/

# Installation Management
# -----------------------

function Install-DF_PowerShell {
    Write-DF_Message_Title -Action 'Installing' -Name 'PowerShell'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Homebrew'
        sh -c 'brew cask install powershell'
    }
    elseif ($IsWindows) {
        Write-DF_Message_Subtitle -Action 'install' -With 'winget'
        Write-DF_Message_Title -Action 'Installing' -Name 'PowerShell'
        cmd /c 'winget install PowerShell --source msstore'
    }
    elseif ($IsLinux) {
        $OS = 'ubuntu1.16.04.1_amd64.deb$'
        $Uri = ($Response.assets | Where-Object { $_.name -match $OS }).browser_download_url
        $Urn = 'powershell-ubuntu1.16.04.1_amd64.deb'
        $InstallerFile = Join-Path -Path $env:TEMP -ChildPath $Urn
        Invoke-WebRequest -Uri $Uri -OutFile $InstallerFile
        # @TODO implement
        Remove-Item -Path $InstallerFile
    }
}

# Commands
# --------

# Help
# ----

function Show-DF_PowerShellDoc {
    Start-DF_Browser https://learn.microsoft.com/powershell/scripting/
}

function Show-DF_PowerShellWeb {
    Start-DF_Browser https://learn.microsoft.com/powershell/
}

# Oh My Posh
# ----------

function Install-DF_OhMyPosh {
    Param(
        [Switch]
        $Font
    )
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    if ($Font -and (Test-DF_Command -Name 'oh-my-posh')) {
        oh-my-posh font install meslo
        Write-DF_Message -Message "Set terminal font to 'MesloLGM Nerd Font'."
    }
}
New-Alias -Name Update-DF_OhMyPosh -Value Install-DF_OhMyPosh

function Show-DF_OhMyPoshDoc {
    Start-DF_Browser https://ohmypo.sh/docs/
}

function Show-DF_OhMyPoshWeb {
    Start-DF_Browser https://ohmypo.sh/
}