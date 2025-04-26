function GetLongList {
    Get-ChildItem -Force "${args}"
}
New-Alias -Name ll -Value GetLongList

function OpenFolderInGui {
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
New-Alias -Name f -Value OpenFolderInGui

function OpenHostsFile {
    if (ExistCommand -Name code) {
        if ($IsMacOS) {
            WriteMessage -Type Warning -Message 'Please close all instances of Visual Studio Code before continuing'
            [void](Read-Host 'Press Enter to continue…')
            sudo code /etc/hosts
        }
        elseif ($IsWindows) {
            code C:\Windows\System32\drivers\etc\hosts
        }
    }
    else {
        WriteMessage -Type Warning -Message "Please install Visual Studio Code and install the 'code' command in PATH."
    }
}
New-Alias -Name hosts -Value OpenHostsFile

function SetLocationPath ([String] $Path, [String] $Directory) {
    $Location = Join-Path -Path $Path -ChildPath $Directory
    if (Test-Path -Path $Location) {
        Push-Location $Location
    }
    else {
        WriteMessage -Type Danger -Message "Cannot find path '${Location}' because it does not exist."
        WriteMessage -Type Info -Message 'Available directories:'
        Get-ChildItem -Name $Path | Write-Host -ForegroundColor DarkGray
    }
}

function SetLocationPathDesktop {
    $DesktopPath = [io.path]::Combine($HOME, 'Desktop')
    if (Test-Path -Path $DesktopPath) {
        Set-Location -Path $DesktopPath
    }
}
New-Alias -Name dt -Value SetLocationPathDesktop

function SetLocationPath_DotfilesInstall {
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
New-Alias -Name d -Value SetLocationPath_DotfilesInstall

function SetLocationPath_Code {
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
        SetLocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name c -Value SetLocationPath_Code

function SetLocationPath_CodeLearning {
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
        SetLocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name cl -Value SetLocationPath_CodeLearning

function SetLocationPath_CodeTest {
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
        SetLocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name ct -Value SetLocationPath_CodeTest

function SetLocationPath_Home {
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
        SetLocationPath -Path $Path -Directory $Directory
    }
}
New-Alias -Name ~ -Value SetLocationPath_Home

function SetLocationPath_UpOne ([String] $Directory) {
    SetLocationPath -Path .. -Directory $Directory
}
New-Alias -Name .. -Value SetLocationPath_UpOne

function SetLocationPath_UpTwo ([String] $Directory) {
    $Path = Join-Path -Path .. -ChildPath ..
    SetLocationPath -Path $Path -Directory $Directory
}
New-Alias -Name ... -Value SetLocationPath_UpTwo
