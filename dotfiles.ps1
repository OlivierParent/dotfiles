# using module .\modules\initialize.psm1
# using module .\modules\messages.psm1
# using module .\modules\configs.psm1
# using module .\modules\paths.psm1
# using module .\modules\core.psm1
# using module .\modules\prompts.psm1
# using module .\modules\repositories.psm1
#  'commandlets'

# Olivier Parent's Dotfiles
# =========================

New-Variable -Name WorkingDirectory -Value $pwd
New-Variable -Name DotfilesInstallPath -Value (Split-Path -Path $MyInvocation.MyCommand.Path) -Option Constant -Scope Global -ErrorAction SilentlyContinue

Set-Location -Path $Global:DotfilesInstallPath

# Loading Modules
# ---------------

@(
    'initialize'
    'messages'
    'configs'
    'core'
    'paths'
    'prompts'
    'repositories'
    'commandlets'
) | ForEach-Object { 
    $Path = [io.path]::Combine($Global:DotfilesInstallPath, 'modules', "${_}.psm1")
    #Write-Host "Loading module '${Path}'"
    Import-Module -Name $Path
    Remove-Variable -Name Path
}

# Loading Application Functions
# -----------------------------

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

if ((Test-DF_Command -Name git) -and (Test-Path -Path .git)) {
    # git pull
}

# Setting Location and Starting Dotfiles
# --------------------------------------

Pop-Location

Set-Location -Path $HOME

if (! $Error) {
    Clear-Host
}

Write-DF_Header

Set-Location $WorkingDirectory
