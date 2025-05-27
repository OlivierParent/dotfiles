# Yarn
# ====
# https://yarnpkg.com/

# Installation Management
# -----------------------

function Install-DF_Yarn {
    Write-DF_Message_Title -Action 'Installing' -Name 'Yarn'
    if ($IsMacOS -or $IsWindows) {
        Update-DF_Npm
        Write-DF_Message_Subtitle -Action 'install' -With 'npm'
        npm install --global yarn
    }
    elseif ($IsLinux) {
        Write-DF_Message_Subtitle -Action 'install' -With 'APT'
        sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
        sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list'
        sh -c 'sudo apt update && sudo apt install yarn'
    }
    if (Test-DF_Command -Name yarn) {
        Write-DF_Message_Version -Name 'Yarn' -Version (yarn --version)
    }
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}

if (Test-DF_Command -Name yarn) {

    # Commands
    # --------

    function Clear-DF_YarnCache {
        Write-DF_Message_Title -Action 'Clearing' -Name 'Yarn cache'
        yarn cache clean --all
    }

    # Help
    # ----

    function Show-DF_YarnWeb {
        Start-DF_Browser https://yarnpkg.com/
    }

}