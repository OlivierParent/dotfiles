function Get-DF_LongList {
    Get-ChildItem -Force "${args}"
}
New-Alias -Name ll -Value Get-DF_LongList

function Show-DF_FolderGui {
    Param(
        [Int]
        [ValidateRange(0, 9)]
        [Alias('w')]
        $Windows = 1,
        [String]
        [Alias('p')]
        $Path = "."
    )
    if ($IsMacOS) {
        $App = 'open'
    }
    elseif ($IsWindows) {
        $App = 'explorer'
    }
    for ($I = 0; $I -lt $Windows; $I++) {
        Invoke-Expression -Command "${App} ${Path}"
    }
}
New-Alias -Name f -Value Show-DF_FolderGui

function Open-DF_HostsFile {
    if (Test-DF_Command -Name code) {
        if ($IsMacOS) {
            Write-DF_Message -Type Warning -Message 'Please close all instances of Visual Studio Code before continuing'
            [void](Read-Host 'Press Enter to continue…')
            sudo code /etc/hosts
        }
        elseif ($IsWindows) {
            code C:\Windows\System32\drivers\etc\hosts
        }
    }
    else {
        Write-DF_Message -Type Warning -Message "Please install Visual Studio Code and install the 'code' command in PATH."
    }
}
New-Alias -Name hosts -Value Open-DF_HostsFile

function Set-DF_LocationPath ([String] $Path, [String] $Directory) {
    $Location = Join-Path -Path $Path -ChildPath $Directory
    if (Test-Path -Path $Location) {
        Push-Location $Location
    }
    else {
        Write-DF_Message -Type Danger -Message "Cannot find path '${Location}' because it does not exist."
        Write-DF_Message -Type Info -Message 'Available directories:'
        Get-ChildItem -Name $Path | Write-Host -ForegroundColor DarkGray
    }
}

function Set-DF_LocationPathDesktop {
    $DesktopPath = [io.path]::Combine($HOME, 'Desktop')
    if (Test-Path -Path $DesktopPath) {
        Set-Location -Path $DesktopPath
    }
}
New-Alias -Name dt -Value Set-DF_LocationPathDesktop

function Set-DF_LocationPath_DotfilesInstall {
    Param(
        [Switch]
        [Alias('c')]
        $Config
    )
    if ($Config) {
        $DotfilesConfigPath = [io.path]::Combine($HOME, '.dotfiles')
        if (Test-Path -Path $DotfilesConfigPath) {
            Set-Location -Path $DotfilesConfigPath
        }
    }
    else {
        Set-Location -Path $DotfilesInstallPath
    }
}
New-Alias -Name d -Value Set-DF_LocationPath_DotfilesInstall

function Set-DF_LocationPathCode {
    [CmdletBinding()]
    Param()
    DynamicParam {
        $Path = Join-Path -Path $HOME -ChildPath Code
        if (! (Test-Path -Path $Path)) {
            New-Item -Path $Path -ItemType Directory
        }
        try {
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Position = 1
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute((Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name))
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $AttributeCollection.Add($ParameterAttribute)
            $AttributeCollection.Add($ValidateSetAttribute)
            $ParameterName = 'Directory'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [String], $AttributeCollection)
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
        }
        catch {}
    }
    Begin {
        try {
            $Directory = $PSBoundParameters[$ParameterName]
        }
        catch {}
    }
    Process {
        Set-DF_LocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name c -Value Set-DF_LocationPathCode

function Set-DF_LocationPathCodeLearning {
    [CmdletBinding()]
    Param()
    DynamicParam {
        $Path = Join-Path -Path $HOME -ChildPath CodeLearning
        if (! (Test-Path -Path $Path)) {
            New-Item -Path $Path -ItemType Directory
        }
        try {
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Position = 1
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute((Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name))
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $AttributeCollection.Add($ParameterAttribute)
            $AttributeCollection.Add($ValidateSetAttribute)
            $ParameterName = 'Directory'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [String], $AttributeCollection)
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
        }
        catch {}
    }
    Begin {
        try {
            $Directory = $PSBoundParameters[$ParameterName]
        }
        catch {}
    }
    Process {
        Set-DF_LocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name cl -Value Set-DF_LocationPathCodeLearning

function Set-DF_LocationPathCodeTest {
    [CmdletBinding()]
    Param()
    DynamicParam {
        $Path = Join-Path -Path $HOME -ChildPath CodeTest
        if (! (Test-Path -Path $Path)) {
            New-Item -Path $Path -ItemType Directory
        }
        try {
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Position = 1
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute((Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name))
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $AttributeCollection.Add($ParameterAttribute)
            $AttributeCollection.Add($ValidateSetAttribute)
            $ParameterName = 'Directory'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [String], $AttributeCollection)
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
        }
        catch {}
    }
    Begin {
        try {
            $Directory = $PSBoundParameters[$ParameterName]
        }
        catch {}
    }
    Process {
        Set-DF_LocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name ct -Value Set-DF_LocationPathCodeTest

function Set-DF_LocationPathHome {
    [CmdletBinding()]
    Param()
    DynamicParam {
        $Path = $HOME
        if (! (Test-Path -Path $Path)) {
            New-Item -Path $Path -ItemType Directory
        }
        try {
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Position = 1
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute((Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name))
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $AttributeCollection.Add($ParameterAttribute)
            $AttributeCollection.Add($ValidateSetAttribute)
            $ParameterName = 'Directory'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [String], $AttributeCollection)
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
        }
        catch {}
    }
    Begin {
        try {
            $Directory = $PSBoundParameters[$ParameterName]
        }
        catch {}
    }
    Process {
        Set-DF_LocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name ~ -Value Set-DF_LocationPathHome

function Set-DF_LocationPathUpOne ([String] $Directory) {
    Set-DF_LocationPath -Path .. -Directory $Directory
}
New-Alias -Name .. -Value Set-DF_LocationPathUpOne

function Set-DF_LocationPathUpTwo ([String] $Directory) {
    $Path = Join-Path -Path .. -ChildPath ..
    Set-DF_LocationPath -Path $Path -Directory $Directory
}
New-Alias -Name ... -Value Set-DF_LocationPathUpTwo
