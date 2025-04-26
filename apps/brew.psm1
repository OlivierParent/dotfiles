# Homebrew
# ========
# https://brew.sh/

if ($IsMacOS) {

    # Installation Management
    # -----------------------

    function Install_Brew {
        WriteMessage_Title -Action 'Installing' -Name 'Homebrew'
        WriteMessage_Subtitle -Action 'install' -With 'Ruby'
        sh -c 'ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"'
        if (ExistCommand -Name brew) {
            WriteMessage_Version -Name 'Homebrew' -Version (brew --version)
        }
        else {
            WriteMessage_Fail -Action 'Installation'
        }
    }

    function Uninstall_Brew {
        Param(
            [Switch]
            $Force
        )
        WriteMessage_Title -Action 'Uninstalling' -Name 'Homebrew'
        if ($Force) {
            WriteMessage -Type Info -Message 'Removing all files...'
            Set-Location -Path /usr/local/
            sh -c 'sudo rm -rf *'
        }
        else {
            WriteMessage_Subtitle -Action 'uninstall' -With 'Ruby'
            sh -c 'ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)\"'
        }
    }

    function Update_Brew {
        Param(
            [Switch]
            $Force
        )
        WriteMessage_Title -Action 'Updating' -Name 'Homebrew'
        if (ExistCommand -Name brew) {
            WriteMessage -Type Info -Message '[1/3] Updating...'
            sh -c 'brew update'
            WriteMessage -Type Info -Message '[2/3] Upgrading...'
            sh -c 'brew upgrade'
            WriteMessage -Type Info -Message '[3/3] Cleaning up...'
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

    function Open_Brew_Web {
        OpenUri https://brew.sh/
    }

}