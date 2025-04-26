function InitConfig {
    Param(
        [Switch]
        $Force
    )
    if ($Force -or (! (Test-Path $Global:DotfilesConfigPath))) {
        WriteMessage -Type Info -Message 'Creating a new config file...'
        New-Item -Path $Global:DotfilesConfigPath -Force
        Set-Variable -Name DotfilesConfig -Value (New-Object -TypeName PSObject) -Scope Global
        SaveConfig
    }
    else {
        WriteMessage -Type Info -Message 'Reading config file...'
        Set-Variable -Name DotfilesConfig -Value (Get-Content -Raw -Path $Global:DotfilesConfigPath | ConvertFrom-Json) -Scope Global
    }
}

function ReadConfig([String] $Name) {
    if (Get-Member -InputObject $Global:DotfilesConfig -Name $Name -MemberType NoteProperty) {
        return $Global:DotfilesConfig.$Name
    }
    else {
        return $null
    }
}

function SaveConfig {
    ConvertTo-Json -InputObject $Global:DotfilesConfig | Out-File -FilePath $Global:DotfilesConfigPath
}

function WriteConfig([String] $Name, [String] $Value) {
    if (Get-Member -InputObject $Global:DotfilesConfig -Name $Name -MemberType NoteProperty) {
        $Global:DotfilesConfig.$Name = $Value
    }
    else {
        Add-Member -InputObject $Global:DotfilesConfig -NotePropertyName $Name -NotePropertyValue $Value
    }
    SaveConfig
}