# NGINX
# =====
# https://nginx.org/

# Installation Management
# -----------------------

function Install_Nginx {
    WriteMessage_Title -Action 'Installing' -Name 'NGINX'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install nginx --devel'
    }
    elseif ($IsWindows) {
        WriteMessage_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install nginx'
    }
    WriteMessage -Type Info -Message 'Configuring...'
    $FileName = 'nginx.conf'
    $SourcePath = [io.path]::Combine($HOME, 'dotfiles', 'settings', $FileName)
    $DestinationPath = [io.path]::Combine($HOME, '.dotfiles', $FileName)
    Copy-Item -Path $SourcePath -Destination $DestinationPath
    if ($IsMacOS) {
        # $NginxConfigDirectory = (brew --prefix nginx) + '/.bottle/etc/nginx'
        $NginxConfigDirectory = '/usr/local/etc/nginx'
    }
    else {
        $NginxConfigDirectory = "${HOME}/scoop/apps/nginx/current/conf".replace('\', '/')
    }
    $FileContent = (Get-Content -Path $DestinationPath).Replace('»NGINX-CONFIG-DIRECTORY«', $NginxConfigDirectory)
    Set-Content -Path $DestinationPath -Value $FileContent
    if (ExistCommand -Name nginx) {
        $Version = (nginx -v)
        WriteMessage_Version -Name 'NGINX' -Version $Version
    }
    else {
        WriteMessage_Fail -Action 'Installation'
    }
}