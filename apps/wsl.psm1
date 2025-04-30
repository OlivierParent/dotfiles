# Windows Subsystem for Linux (WSL)
# =================================
# https://learn.microsoft.com/windows/wsl/install

# Installation Management
# -----------------------
if ($IsWindows) {
    function Install-DF_Wsl {
        Write-DF_Message_Title -Action 'Installing' -Name 'Windows Subsystem for Linux'
        Write-DF_Message_Subtitle -Action 'install' -With 'WSL'
        wsl --install
    }
}

# Commands
# --------

# Help
# ----
if ($IsWindows) {
    function Show-DF_WslDoc {
        Start-DF_Browser https://learn.microsoft.com/windows/wsl/
    }

    function Show-DF_WslWeb {
        Start-DF_Browser https://learn.microsoft.com/windows/wsl/
    }
}