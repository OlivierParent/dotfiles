function Install-DF_NuGet {
    if ($IsWindows) {
        Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile "$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\PowerShellGet\NuGet.exe"
    }
}

function Install-DF_Module {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )
    Install-Module -Name $Name -Repository 'dotfiles'
}

function Publish-DF_Module {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )
    Publish-Module -Path $Path -Repository 'dotfiles' -Verbose
}

function Register-DF_Repository {
    $RepositoryLocation = [io.path]::Combine($HOME, 'dotfiles', 'repository')
    Register-PSRepository -Name 'dotfiles' -SourceLocation $RepositoryLocation
}

function Unregister-DF_Repository {
    Unregister-PSRepository -Name 'dotfiles'
}

function Update-DF_Module {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Blender-Module')]
        [String]
        $Name
    )
    Install-Module -Name $Name -Repository 'dotfiles'
}