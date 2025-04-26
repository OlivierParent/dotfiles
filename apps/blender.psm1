# Blender
# =======
# https://www.blender.org/

# Commands
# --------

if ($IsWindows) {

    function Run_BlenderInfo {
        query user
    }

    function RunApp_Blender {
        Param(
            $SessionName = 'console'
        )
        WriteMessage -Type Primary -Inverse -Message 'Starting Blender from Remote Desktop...'
        Start-Process tscon.exe -Verb RunAs -ArgumentList "$SessionName /DEST:console" -Wait
        Start-Process 'C:\Program Files\Blender Foundation\Blender\2.80\blender.exe'
    }

    function SetVersion_BlenderMicrosoftStore {
        WriteConfig -Name Blender -Value ((Get-AppxPackage –AllUsers | Where-Object { $_.Name -eq 'BlenderFoundation.Blender' }).Version.Split('.')[0..1] -join '.')
    }

}

# Help
# ----

function Open_Blender_Doc {
    OpenUri https://docs.blender.org/manual/en/latest/
}

function Open_Blender_Web {
    OpenUri https://www.blender.org/
}

# Paths
# -----

function SetLocationPath_BlenderAddOns {
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
        WriteMessage -Type Danger -Message "Cannot find path '${BlenderPath}' because it does not exist."
    }
}
New-Alias -Name ba -Value SetLocationPath_BlenderAddOns