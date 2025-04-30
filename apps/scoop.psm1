# Scoop
# =====
# https://scoop.sh/

if ($IsWindows) {

    # Installation Management
    # -----------------------

    function Install-DF_Scoop {
        Write-DF_Message -Type Primary -Inverse -Message 'Installing Scoop'
        Write-DF_Message -Type Info -Inverse -Message 'Installing...'
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        if (Test-DF_Command -Name scoop) {
            cmd /c 'scoop bucket add extras'
        }
        else {
            Write-DF_Message_Fail -Action 'Installation'
        }
    }

    function Uninstall-DF_Scoop {
        Write-DF_Message_Title -Action 'Uninstalling' -Name 'Scoop'
        if (Test-DF_Command -Name scoop) {
            Write-DF_Message_Subtitle -Action 'uninstall' -With 'Scoop'
            cmd /c 'scoop uninstall scoop'
        }
        else {
            Write-DF_Message_Fail -Action 'Uninstallation'
        }
    }

    function Update-DF_Scoop {
        Write-DF_Message_Title -Action 'Updating' -Name 'Scoop'
        if (Test-DF_Command -Name scoop) {
            Write-DF_Message -Type Info -Message '[1/4] Updating Scoop...'
            cmd /c 'scoop update'
            Write-DF_Message -Type Info -Message '[2/4] Updating apps...'
            cmd /c 'scoop update *'
            Write-DF_Message -Type Info -Message '[3/4] Cleaning up apps...'
            cmd /c 'scoop cleanup *'
            Write-DF_Message -Type Info -Message '[4/4] Clearing cache...'
            cmd /c 'scoop cache rm *'
        }
    }

    if (Test-DF_Command -Name scoop) {

        # Help
        # ----

        function Show-DF_ScoopWeb {
            Start-DF_Browser https://scoop.sh/
        }

    }

}
