# Homebrew
# ========
# https://brew.sh/

if ($IsMacOS) {

    # Installation Management
    # -----------------------

    function Install-DF_Brew {
        Write-DF_Message_Title -Action 'Installing' -Name 'Homebrew'
        Write-DF_Message_Subtitle -Action 'install' -With 'Ruby'
        sh -c 'ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"'
        if (Test-DF_Command -Name brew) {
            Write-DF_Message_Version -Name 'Homebrew' -Version (brew --version)
        }
        else {
            Write-DF_Message_Fail -Action 'Installation'
        }
    }

    function Uninstall-DF_Brew {
        Param(
            [Switch]
            $Force
        )
        Write-DF_Message_Title -Action 'Uninstalling' -Name 'Homebrew'
        if ($Force) {
            Write-DF_Message -Type Info -Message 'Removing all files...'
            Set-Location -Path /usr/local/
            sh -c 'sudo rm -rf *'
        }
        else {
            Write-DF_Message_Subtitle -Action 'uninstall' -With 'Ruby'
            sh -c 'ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)\"'
        }
    }

    function Update-DF_Brew {
        Param(
            [Switch]
            $Force
        )
        Write-DF_Message_Title -Action 'Updating' -Name 'Homebrew'
        if (Test-DF_Command -Name brew) {
            Write-DF_Message -Type Info -Message '[1/3] Updating...'
            sh -c 'brew update'
            Write-DF_Message -Type Info -Message '[2/3] Upgrading...'
            sh -c 'brew upgrade'
            Write-DF_Message -Type Info -Message '[3/3] Cleaning up...'
            if ($Force) {
                sh -c 'brew cleanup -s'
            }
            else {
                sh -c 'brew cleanup'
            }
        }
    }

    # Help
    # ----

    function Show-DF_BrewWeb {
        Start-DF_Browser https://brew.sh/
    }

}
