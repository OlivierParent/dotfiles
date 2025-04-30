# Windows
# =======
# https://www.microsoft.com/windows/

if ($IsWindows) {

    # Utility functions
    # -----------------

    function Disable-DF_HypervisorPlatform {
        Write-DF_Message_Title -Action 'Disabling' -Name 'Hypervisor Platform'
        $admin = IsAdministrator
        if ($admin) {
            dism.exe /Online /Disable-Feature:HypervisorPlatform
        }
        else {
            Write-DF_Message_Administrator
        }
    }

    function Disable-DF_HypervisorLaunch {
        Write-DF_Message_Title -Action 'Disabling' -Name 'Hypervisor Launch'
        $admin = IsAdministrator
        if ($admin) {
            bcdedit /set hypervisorlaunchtype off
        }
        else {
            Write-DF_Message_Administrator
        }
    }

    function Install-DF_Ubuntu {
        Write-DF_Message_Title -Action 'Installing' -Name 'Bash on Ubuntu on Windows'
        if (Test-DF_Command -Name LxRun.exe) {
            Write-DF_Message_Subtitle -Action 'install' -With 'LxRun'
            LxRun.exe /install /y
        }
        else {
            Write-DF_Message_Fail -Action 'Installation'
        }

    }

    function Reset-DF_Ubuntu {
        Write-DF_Message_Title -Action 'Resetting' -Name 'Bash on Ubuntu on Windows'
        Write-DF_Message_Subtitle -Action 'reset' -With 'LxRun'
        LxRun.exe /uninstall /full /y
        LxRun.exe /install /y
    }

    function Uninstall-DF_Ubuntu {
        Write-DF_Message_Title -Action 'Uninstalling' -Name 'Bash on Ubuntu on Windows'
        Write-DF_Message_Subtitle -Action 'uninstall' -With 'LxRun'
        LxRun.exe /uninstall /y
    }

}