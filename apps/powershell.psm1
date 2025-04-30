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
        Write-DF_Message -Type Warning -Inverse -Message 'Get PowerShell from Microsoft Store!'
        Start-DF_Browser -Edge https://apps.microsoft.com/detail/9mz1snwt0n5d?launch=true&mode=full
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

# Bug Fixes
# -----------
# PowerShell Core 7.5.0
#Enable-ExperimentalFeature PSFeedbackProvider

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
