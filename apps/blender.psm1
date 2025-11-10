# Blender
# =======
# https://www.blender.org/

# Commands
# --------

if ($IsWindows) {

    function Install-DF_Blender {
        Write-DF_Message_Title -Action 'Installing' -Name 'Blender'
        Write-DF_Message_Subtitle -Action 'install' -With 'winget'
        cmd /c 'winget install Blender --source msstore'
    }
    
    function Start-DF_BlenderInfo {
        query user
    }

    function Start-DF_Blender {
        Param(
            $SessionName = 'console'
        )
        Write-DF_Message -Type Primary -Inverse -Message 'Starting Blender from Remote Desktop...'
        Start-Process tscon.exe -Verb RunAs -ArgumentList "$SessionName /DEST:console" -Wait
        Start-Process 'C:\Program Files\Blender Foundation\Blender\2.80\blender.exe'
    }

    function Set-DF_BlenderMicrosoftStoreVersion {
        Write-DF_Config -Name Blender -Value ((Get-AppxPackage –AllUsers | Where-Object { $_.Name -eq 'BlenderFoundation.Blender' }).Version.Split('.')[0..1] -join '.')
    }

}

# Help
# ----

function Show-DF_BlenderDoc {
    Start-DF_Browser https://docs.blender.org/manual/en/latest/
}

function Show-DF_BlenderWeb {
    Start-DF_Browser https://www.blender.org/
}

# Paths
# -----

function Set-DF_LocationPathBlenderAddOns {
    Param(
        [String]
        $Version = '4.4'
    )
    $BlenderVersion = ReadConfig -Name Blender
    if ($BlenderVersion) {
        $Version = $BlenderVersion
    }
    if ($IsMacOS) {
        $BlenderPath = [io.path]::Combine($HOME, 'Library', 'Application Support', 'Blender', $Version, 'scripts', 'addons')
    }
    elseif ($IsWindows) {    
        $BlenderPath = [io.path]::Combine($HOME, 'AppData', 'Roaming', 'Blender Foundation', 'Blender', $Version, 'scripts', 'addons')
    }
    if (Test-Path -Path $BlenderPath) {
        Set-Location -Path $BlenderPath
    }
    else {
        Write-DF_Message -Type Danger -Message "Cannot find path '${BlenderPath}' because it does not exist."
    }
}
New-Alias -Name ba -Value Set-DF_LocationPathBlenderAddOns