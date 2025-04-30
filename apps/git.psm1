# Git and GitHub
# ==============

# Installation Management
# -----------------------

function Install-DF_Git {
    Write-DF_Message_Title -Action 'Installing' -Name 'Git'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install git'
    }
    elseif ($IsWindows) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install git'
    }
    if (Test-DF_Command -Name git) {
        if ($IsWindows) {
            git config --global credential.helper wincred
        }
        Write-DF_Message_Version -Name 'Git' -Version (git --version).Split(' ')[2]
    }
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}

function Install-DF_GitIgnoreGlobal {
    if (! (Test-DF_Command -Name git)) {
        Install_Git
    }
    Write-DF_Message_Title -Action 'Installing' -Name 'GitIgnore Global'
    $GitIgnoreSource = Join-Path -Path $Global:DotfilesInstallPath -ChildPath 'preferences' | Join-Path -ChildPath 'gitignore_global'
    git config --global core.excludesfile $GitIgnoreSource
}

function Install-DF_GitHubCLI {
    Write-DF_Message_Title -Action 'Installing' -Name 'GitHub CLI'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install gh'
    }
    elseif ($IsWindows) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install gh'
    }
    if (Test-DF_Command -Name gh) {
        Write-DF_Message_Version -Name 'GitHub CLI' -Version (gh --version).Split(' ')[2]
    }
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}

if (Test-DF_Command -Name git) {

    function Update-DF_GitBrowserlist {
        npx update-browserslist-db@latest
    }

    function Publish-DF_GitWip {
        git add . && git commit -a -m [WIP] && git push --set-upstream origin main
    }
    Set-Alias -Name wip -Value Publish-DF_GitWip

    # Help
    # ----

    function Show-DF_GitWeb {
        Start-DF_Browser https://git-scm.com/
    }

    function Show-DF_GitHubWeb {
        Start-DF_Browser https://github.com/
    }
    Set-Alias -Name github -Value Show-DF_GitHubWeb

    if (Test-DF_Command -Name gh) {

        function Show-DF_GitHubCLI_Web {
            Start-DF_Browser https://cli.github.com/
        }

    }

}