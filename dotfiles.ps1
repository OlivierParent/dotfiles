# Olivier Parent's Dotfiles
# =========================

New-Variable -Name WorkingDirectory -Value $pwd
New-Variable -Name DotfilesInstallPath -Value (Split-Path -Path $MyInvocation.MyCommand.Path) -Option Constant -Scope Global -ErrorAction SilentlyContinue

Set-Location -Path $Global:DotfilesInstallPath

# Loading Modules
# ---------------

@(
    'messages'
    'configs'
    'core'
    'paths'
    'prompts'
    'apps'
) | ForEach-Object { 
    $Path = [io.path]::Combine($Global:DotfilesInstallPath, 'modules', "${_}.psm1")
    #Write-Host "Loading module '${Path}'"
    Import-Module -Name $Path
    Remove-Variable -Name Path
}

# Loading Application Fuctions
# ----------------------------

@(
    'blender'
    'brew'
    'browsers'
    'font'
    'git'
    'macos'
    'nginx'
    'node'
    'powershell'
    'rust'
    'scoop'
    'windows'
    'wsl'
    'xcode'
    'yarn'
) | ForEach-Object { 
    $Path = [io.path]::Combine($Global:DotfilesInstallPath, 'apps', "${_}.psm1")
    #Write-Host "Loading application '${Path}'"
    Import-Module -Name $Path
    Remove-Variable -Name Path
}

# Loading Optional Custom Module
# ------------------------------

if (Test-Path -Path $Global:DotfilesCustomModulePath) {
    Import-Module -Name $Global:DotfilesCustomModulePath
}

# Update Dotfiles
# ---------------

if ((ExistCommand -Name git) -and (Test-Path -Path .git)) {
    git pull
}

# Setting Location and Starting Dotfiles
# --------------------------------------

Pop-Location

Set-Location -Path $HOME

if (! $Error) {
    Clear-Host
}

DotfilesHeader

Set-Location $WorkingDirectory
