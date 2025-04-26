# Windows
# =======
# https://www.microsoft.com/windows/

if ($IsWindows) {

    # Utility functions
    # -----------------

    function Disable_HypervisorPlatform {
        WriteMessage_Title -Action 'Disabling' -Name 'Hypervisor Platform'
        $admin = IsAdministrator
        if ($admin) {
            dism.exe /Online /Disable-Feature:HypervisorPlatform
        }
        else {
            WriteMessage_Administrator
        }
    }

    function Disable_HypervisorLaunch {
        WriteMessage_Title -Action 'Disabling' -Name 'Hypervisor Launch'
        $admin = IsAdministrator
        if ($admin) {
            bcdedit /set hypervisorlaunchtype off
        }
        else {
            WriteMessage_Administrator
        }
    }

    function Install_Ubuntu {
        WriteMessage_Title -Action 'Installing' -Name 'Bash on Ubuntu on Windows'
        if (ExistCommand -Name LxRun.exe) {
            WriteMessage_Subtitle -Action 'install' -With 'LxRun'
            LxRun.exe /install /y
        }
        else {
            WriteMessage_Fail -Action 'Installation'
        }

    }

    function Reset_Ubuntu {
        WriteMessage_Title -Action 'Resetting' -Name 'Bash on Ubuntu on Windows'
        WriteMessage_Subtitle -Action 'reset' -With 'LxRun'
        LxRun.exe /uninstall /full /y
        LxRun.exe /install /y
    }

    function Uninstall_Ubuntu {
        WriteMessage_Title -Action 'Uninstalling' -Name 'Bash on Ubuntu on Windows'
        WriteMessage_Subtitle -Action 'uninstall' -With 'LxRun'
        LxRun.exe /uninstall /y
    }

}