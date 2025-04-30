# NGINX
# =====
# https://nginx.org/

# Installation Management
# -----------------------

function Install-DF_Nginx {
    Write-DF_Message_Title -Action 'Installing' -Name 'NGINX'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install nginx --devel'
    }
    elseif ($IsWindows) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install nginx'
    }
    Write-DF_Message -Type Info -Message 'Configuring...'
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
    if (Test-DF_Command -Name nginx) {
        $Version = (nginx -v)
        Write-DF_Message_Version -Name 'NGINX' -Version $Version
    }
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}