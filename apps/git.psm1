# Git and GitHub
# ==============

# Installation Management
# -----------------------

function Install_Git {
    WriteMessage_Title -Action 'Installing' -Name 'Git'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install git'
    }
    elseif ($IsWindows) {
        WriteMessage_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install git'
    }
    if (ExistCommand -Name git) {
        if ($IsWindows) {
            git config --global credential.helper wincred
        }
        WriteMessage_Version -Name 'Git' -Version (git --version).Split(' ')[2]
    }
    else {
        WriteMessage_Fail -Action 'Installation'
    }
}

function Install_GitIgnoreGlobal {
    if (! (ExistCommand -Name git)) {
        Install_Git
    }
    WriteMessage_Title -Action 'Installing' -Name 'GitIgnore Global'
    $GitIgnoreSource = Join-Path -Path $Global:DotfilesInstallPath -ChildPath 'preferences' | Join-Path -ChildPath 'gitignore_global'
    git config --global core.excludesfile $GitIgnoreSource
}

function Install_GitHubCLI {
    WriteMessage_Title -Action 'Installing' -Name 'GitHub CLI'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install gh'
    }
    elseif ($IsWindows) {
        WriteMessage_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install gh'
    }
    if (ExistCommand -Name gh) {
        WriteMessage_Version -Name 'GitHub CLI' -Version (gh --version).Split(' ')[2]
    }
    else {
        WriteMessage_Fail -Action 'Installation'
    }
}

if (ExistCommand -Name git) {

    # Commands
    # --------

    function Git_UpdateBrowserlist {
        npx update-browserslist-db@latest
    }

    function Git_Wip {
        git add . && git commit -a -m [WIP] && git push --set-upstream origin main
    }
    Set-Alias -Name wip -Value Git_Wip

    # Help
    # ----

    function Open_Git_Web {
        OpenUri https://git-scm.com/
    }

    function Open_GitHub_Web {
        OpenUri https://github.com/
    }
    Set-Alias -Name github -Value Open_GitHub_Web

    if (ExistCommand -Name gh) {

        function Open_GitHubCLI_Web {
            OpenUri https://cli.github.com/
        }

    }

}