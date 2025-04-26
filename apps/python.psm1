# Python
# ======
# https://www.python.org/

# Installation Management
# -----------------------

function InstallApp_Python {
    WriteMessage_Title -Action 'Installing' -Name 'Python'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install python'
        python3 --version
        pip3 --version
    }
    elseif ($IsWindows) {
        WriteMessage_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install python'
    }
    elseif ($IsLinux) {
        $Version = '3.13.3'
        WriteMessage_Subtitle -Action 'install' -With 'APT'
        sh -c 'sudo apt update'
        sh -c 'sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev'
        cd /usr/src
        sh -c "sudo wget https://www.python.org/ftp/python/${Version}/Python-${Version}.tgz"
        sh -c 'sudo tar -xf Python-${Version}.tgz'
        cd /usr/src/Python-${Version}/
        sh -c 'sudo ./configure --enable-optimizations'
        sh -c 'sudo make'
        cd /usr/src/Python-${Version}/
        sh -c 'sudo make install'
    }
}

# Paths
# -----

New-Alias -Name python -Value python3
