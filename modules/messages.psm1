function Write-DF_Message {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Message,
        [ValidateSet('Danger', 'Info', 'Mute', 'Primary', 'Strong', 'Success', 'Warning')]
        [String]
        $Type,
        [Switch]
        $Inverse,
        [Switch]
        $NoNewline
    )
    switch ($Type) {
        # Black        Cyan         DarkCyan     DarkGreen    DarkRed      Gray         Magenta      White
        # Blue         DarkBlue     DarkGray     DarkMagenta  DarkYellow   Green        Red          Yellow
        'Danger' {
            $Foreground = 'Red'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'White'
            }
        }
        'Info' {
            $Foreground = 'Cyan'
            if ($Inverse) {
                $Background = 'Blue'
                $Foreground = 'White'
            }
        }
        'Mute' {
            $Foreground = 'DarkGray'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'Black'
            }
        }
        'Primary' {
            $Foreground = 'Magenta'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'White'
            }
        }
        'Strong' {
            $Foreground = 'White'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'Black'
            }
        }
        'Success' {
            $Foreground = 'Green'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'Black'
            }
        }
        'Warning' {
            $Foreground = 'Yellow'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'Black'
            }
        }
        Default {
            $Foreground = 'Gray'
            if ($Inverse) {
                $Background = $Foreground
                $Foreground = 'Black'
            }
        }
    }
    if ($Background) {
        Write-Host " ${Message} " -BackgroundColor $Background -ForegroundColor $Foreground -NoNewline:$NoNewline;
    }
    else {
        Write-Host "${Message}" -ForegroundColor $Foreground -NoNewline:$NoNewline;
    }
}

# Messages
# --------

function Write-DF_Message_Administrator {
    Write-DF_Message -Type Danger -Message 'Run this window as administrator and try again.'
}

function Write-DF_Message_Fail {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Installation', 'Removal', 'Uninstallation', 'Updating')]
        [String]
        $Action
    )
    Write-DF_Message -Type Danger -Message "${Action} was not completed successfully."
}

function Write-DF_Message_Subtitle {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('install', 'remove', 'reset', 'uninstall', 'update')]
        [String]
        $Action,
        [Parameter(Mandatory = $true)]
        [ValidateSet('APT', 'Homebrew', 'LxRun', 'npm', 'NVM', 'Ruby', 'Scoop', 'WSL')]
        [String]
        $With
    )
    Write-DF_Message -Type Info -Message "Using '${With}' to ${Action}..."
}


function Write-DF_Message_Title {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Disabling', 'Initializing', 'Installing', 'Uninstalling', 'Reinstalling', 'Removing', 'Resetting', 'Restarting', 'Updating')]
        [String]
        $Action,
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )
    Write-DF_Message -Type Primary -Inverse -Message "${Action} '${Name}'"
}

function Write-DF_Message_Version {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Name,
        [Switch]
        $Fail,
        [Parameter(Mandatory = $true)]
        [String]
        $Version
    )
    Write-DF_Message -Type $(if ($Fail) { 'Danger' } else { 'Success' }) -Message "Installed version of '${Name}': ${Version}"
}
