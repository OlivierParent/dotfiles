# Scoop
# =====
# https://scoop.sh/

if ($IsWindows) {

    # Installation Management
    # -----------------------

    function Install_Scoop {
        WriteMessage -Type Primary -Inverse -Message 'Installing Scoop'
        WriteMessage -Type Info -Inverse -Message 'Installing...'
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        if (ExistCommand -Name scoop) {
            cmd /c 'scoop bucket add extras'
        }
        else {
            WriteMessage_Fail -Action 'Installation'
        }
    }

    function Uninstall_Scoop {
        WriteMessage_Title -Action 'Uninstalling' -Name 'Scoop'
        if (ExistCommand -Name scoop) {
            WriteMessage_Subtitle -Action 'uninstall' -With 'Scoop'
            cmd /c 'scoop uninstall scoop'
        } else {
            WriteMessage_Fail -Action 'Uninstallation'
        }
    }

    function Update_Scoop {
        WriteMessage_Title -Action 'Updating' -Name 'Scoop'
        if (ExistCommand -Name scoop) {
            WriteMessage -Type Info -Message '[1/4] Updating Scoop...'
            cmd /c 'scoop update'
            WriteMessage -Type Info -Message '[2/4] Updating apps...'
            cmd /c 'scoop update *'
            WriteMessage -Type Info -Message '[3/4] Cleaning up apps...'
            cmd /c 'scoop cleanup *'
            WriteMessage -Type Info -Message '[4/4] Clearing cache...'
            cmd /c 'scoop cache rm *'
        }
    }

    if (ExistCommand -Name scoop) {

        # Help
        # ----

        function Open_Scoop_Web {
            OpenUri https://scoop.sh/
        }

    }

}
