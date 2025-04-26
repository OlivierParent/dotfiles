New-Variable -Name DotfilesConfigPath -Value ([io.path]::Combine($HOME, '.dotfiles', 'config.json')) -Option Constant -Scope Global -ErrorAction SilentlyContinue
New-Variable -Name DotfilesCustomModulePath -Value ([io.path]::Combine($HOME, '.dotfiles', 'custom.psm1')) -Option Constant -Scope Global -ErrorAction SilentlyContinue
New-Variable -Name DotfilesCustomModuleTemplatePath -Value ([io.path]::Combine($Global:DotfilesInstallPath, 'templates', 'custom.psm1')) -Option Constant -Scope Global -ErrorAction SilentlyContinue
New-Variable -Name DotfilesName -Value (Get-Content -Path (Join-Path -Path $Global:DotfilesInstallPath -ChildPath VERSION) | Select-Object -First 1) -Option Constant -Scope Global -ErrorAction SilentlyContinue
New-Variable -Name DotfilesNewAppModulePath -Value ([io.path]::Combine($Global:DotfilesInstallPath, 'apps', 'module.psm1')) -Option Constant -Scope Global -ErrorAction SilentlyContinue
New-Variable -Name DotfilesNewAppModuleTemplatePath -Value ([io.path]::Combine($Global:DotfilesInstallPath, 'templates', 'module.psm1')) -Option Constant -Scope Global -ErrorAction SilentlyContinue
New-Variable -Name DotfilesVersion -Value (Get-Content -Path (Join-Path -Path $Global:DotfilesInstallPath -ChildPath VERSION) | Select-Object -First 1 -Skip 1) -Option Constant -Scope Global -ErrorAction SilentlyContinue

function ExistCommand {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )
    return [Bool](Get-Command -Name $Name -CommandType Application -ErrorAction Ignore)
}

function SetEnvironment {
    if ($IsMacOS) {
        $Locale = 'nl_BE.UTF-8'
        [System.Environment]::SetEnvironmentVariable('LANG', $Locale)
        [System.Environment]::SetEnvironmentVariable('LC_ALL', $Locale)

        $EnvironmentPath = @()

        # First
        $EnvironmentPath += @(
            # "${HOME}/.rbenv/shims"
        )

        $AndroidSdkPath = "${HOME}/Library/Android/sdk/tools"
        if (Test-Path -Path $AndroidSdkPath) {
            $EnvironmentPath += $AndroidSdkPath
        }

        $DotNetCore = '/usr/local/share/dotnet/dotnet'
        if (Test-Path -Path $DotNetCore) {
            $EnvironmentPath += $DotNetCore
        }

        # User Paths
        $EnvironmentPath += @( 
            '/opt/homebrew/bin',
            '/usr/local/bin',
            '/usr/bin',
            '/bin'
        )

        # Superuser Paths
        $EnvironmentPath += @(
            '/usr/local/sbin',
            '/usr/sbin',
            '/sbin'
        )

        # Last
        $Yarn = "${HOME}/.yarn/bin"
        if (Test-Path -Path $Yarn) {
            $EnvironmentPath += $Yarn
        }

        [System.Environment]::SetEnvironmentVariable('PATH', $EnvironmentPath -join ':')
    }
    elseif ($IsWindows) {
        $EnvironmentPath = [System.Environment]::GetEnvironmentVariable('Path').Split([io.path]::PathSeparator)

        # .Net Core Paths
        $DotNetCorePath = 'C:\Program Files\dotnet'
        if (Test-Path -Path $DotNetCorePath) {
            $EnvironmentPath += $DotNetCorePath
        }

        [System.Environment]::SetEnvironmentVariable('Path', $EnvironmentPath -join [io.path]::PathSeparator)
    }
}
SetEnvironment

function AddToEnvironmentPath {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Path,
        [Switch]
        $First
    )
    $EnvironmentPath = [System.Environment]::GetEnvironmentVariable('Path').Split([io.path]::PathSeparator)

    if ($First) {
        $EnvironmentPath = @($Path) + $EnvironmentPath
    }
    else {
        $EnvironmentPath += @($Path)
    }
    
    [System.Environment]::SetEnvironmentVariable('Path', $EnvironmentPath -join [io.path]::PathSeparator)
}

function DotfilesHeader {
    if ($IsMacOS) {
        $OS = 'macOS'
    }
    elseif ($IsWindows) {
        $OS = 'Windows'
    }
    elseif ($IsLinux) {
        $OS = 'Linux'
    }
    else {
        $OS = 'unknown operating system'
    }
    $PSVersion = $PSVersionTable.PSVersion.ToString()
    WriteMessage -Type Info -Inverse -Message "${Global:DotfilesName}" -NoNewline
    WriteMessage -Type Strong -Message " ${Global:DotfilesVersion}" -NoNewline
    WriteMessage -Type Mute -Message " in PowerShell ${PSEdition} ${PSVersion} on ${OS}"
}

function FindListeners {
    Param(
        [Parameter(Mandatory = $true)]
        [Int16]
        $Port
    )
    if ($IsMacOS) {
        (sudo lsof -i ":${Port}" | Where-Object { $_ -match 'LISTEN' })
    }
    elseif ($IsWindows) {
        (NETSTAT.EXE -ao | Where-Object { $_ -match 'Proto' -or ($_ -match ":${Port} " -and $_ -match 'LISTENING') })
    }
}

function InitCustomModule {
    WriteMessage_Title -Action 'Initializing' -Name 'Dotfiles Custom Module'
    if (! (Test-Path $Global:DotfilesCustomModulePath)) {
        if (Test-Path $Global:DotfilesCustomModuleTemplatePath) {
            WriteMessage -Type Info -Message 'Creating Dotfiles Custom Module...'
            Copy-Item -Path $Global:DotfilesCustomModuleTemplatePath -Destination $Global:DotfilesCustomModulePath
            WriteMessage -Type Success -Message "Dotfiles Custom Module '${Global:DotfilesCustomModulePath}' created."
        }
        else {
            WriteMessage -Type Warning -Message 'Could nof find source file for Dotfiles Custom Module.'
        }
    } 
    else {
        WriteMessage -Type Warning -Message "Dotfiles Custom Module already exists. Delete '${Global:DotfilesCustomModulePath}' first."
    }
}

if ($IsWindows) {
    function IsAdministrator {
        $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }
}

function NewAppModule {
    $NewAppModulePath = $Global:DotfilesNewAppModulePath.Replace('module.psm1', "module-$(Get-Date -Format 'yyyyMMddHHmmss').psm1")
    Copy-Item -Path $Global:DotfilesNewAppModuleTemplatePath -Destination $NewAppModulePath
}

function ReloadDotfiles {
    pwsh -NoLogo -NoExit -Command "cd $pwd"
    Stop-Process -Id $PID
}
New-Alias -Name reload -Value ReloadDotfiles

function X {
    exit
}

InitConfig