# Windows Subsystem for Linux (WSL)
# =================================
# https://learn.microsoft.com/windows/wsl/install

# Installation Management
# -----------------------
if ($IsWindows) {
    function Install_WSL {
        WriteMessage_Title -Action 'Installing' -Name 'Windows Subsystem for Linux'
        WriteMessage_Subtitle -Action 'install' -With 'WSL'
        wsl --install
    }
}

# Commands
# --------


# Help
# ----
if ($IsWindows) {
    function Open_WSL_Doc {
        OpenUri https://learn.microsoft.com/windows/wsl/
    }

    function Open_WSL_Web {
        OpenUri https://learn.microsoft.com/windows/wsl/
    }
}