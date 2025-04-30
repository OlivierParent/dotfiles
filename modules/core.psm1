function Test-DF_Command {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )
    return [Bool](Get-Command -Name $Name -CommandType Application -ErrorAction Ignore)
}

function Set-DF_Environment {
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
Set-DF_Environment

function Add-DF_EnvironmentPath {
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

function Write-DF_Header {
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
    Write-DF_Message -Type Info -Inverse -Message "${Global:DotfilesName}" -NoNewline
    Write-DF_Message -Type Strong -Message " ${Global:DotfilesVersion}" -NoNewline
    Write-DF_Message -Type Mute -Message " in PowerShell ${PSEdition} ${PSVersion} on ${OS}"
}

function Find-DF_Listeners {
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

function Initialize-DF_CustomModule {
    Write-DF_Message_Title -Action 'Initializing' -Name 'Dotfiles Custom Module'
    if (! (Test-Path $Global:DotfilesCustomModulePath)) {
        if (Test-Path $Global:DotfilesCustomModuleTemplatePath) {
            Write-DF_Message -Type Info -Message 'Creating Dotfiles Custom Module...'
            Copy-Item -Path $Global:DotfilesCustomModuleTemplatePath -Destination $Global:DotfilesCustomModulePath
            Write-DF_Message -Type Success -Message "Dotfiles Custom Module '${Global:DotfilesCustomModulePath}' created."
        }
        else {
            Write-DF_Message -Type Warning -Message 'Could nof find source file for Dotfiles Custom Module.'
        }
    } 
    else {
        Write-DF_Message -Type Warning -Message "Dotfiles Custom Module already exists. Delete '${Global:DotfilesCustomModulePath}' first."
    }
}

if ($IsWindows) {
    function Test-DF_IsAdministrator {
        $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }
}

function New-DF_AppModule {
    $NewAppModulePath = $Global:DotfilesNewAppModulePath.Replace('module.psm1', "module-$(Get-Date -Format 'yyyyMMddHHmmss').psm1")
    Copy-Item -Path $Global:DotfilesNewAppModuleTemplatePath -Destination $NewAppModulePath
}

function Update-DF_Dotfiles {
    pwsh -NoLogo -NoExit -Command "cd $pwd"
    Stop-Process -Id $PID
}
New-Alias -Name reload -Value Update-DF_Dotfiles

function Exit-DF_X {
    exit
}
New-Alias -Name x -Value Exit-DF_X

Initialize-DF_Config