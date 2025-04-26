# Yarn
# ====
# https://yarnpkg.com/

# Installation Management
# -----------------------

function Install_Yarn {
    WriteMessage_Title -Action 'Installing' -Name 'Yarn'
    if ($IsMacOS -or $IsWindows) {
        Update_Npm
        WriteMessage_Subtitle -Action 'install' -With 'npm'
        npm install --global yarn
    }
    elseif ($IsLinux) {
        WriteMessage_Subtitle -Action 'install' -With 'APT'
        sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
        sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list'
        sh -c 'sudo apt update && sudo apt install yarn'
    }
    if (ExistCommand -Name yarn) {
        WriteMessage_Version -Name 'Yarn' -Version (yarn --version)
    }
    else {
        WriteMessage_Fail -Action 'Installation'
    }
}

if (ExistCommand -Name yarn) {

    # Commands
    # --------

    # Help
    # ----

    function Open_Yarn_Web {
        OpenUri https://yarnpkg.com/
    }

}