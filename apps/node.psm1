# Node.js
# =======
# https://nodejs.org/en

# Installation Management
# -----------------------

function Install_Node {
    WriteMessage_Title -Action 'Installing' -Name 'Node.js'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'NVM'
        # nvm install
        nvm install --lts
        
    }
    elseif ($IsWindows) {
        $Latest = (((nvm list available) | Select-Object -Index 3).Split('|') | Select-Object -Index 2).Trim()
        WriteMessage_Subtitle -Action 'install' -With 'NVM'
        nvm.exe install $Latest
    }
    Update_Npm
}

function Install_Nvm {
    WriteMessage_Title -Action 'Installing' -Name 'NVM (Node Version Manager)'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install nvm'
    }
    elseif ($IsWindows) {
        WriteMessage_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install nvm'
    }
    if (ExistCommand -Name nvm) {
        WriteMessage_Version -Name 'NVM' -Version $(if ($IsMacOS) { nvm --version } elseif ($IsWindows) { nvm version })
    } 
    else {
        WriteMessage_Fail -Action 'Installation'
    }
}

# Commands
# --------

function Init_Node {
    if ($IsMacOS) {
        $Version = ReadConfig -Name Node
        if ($Version) {
            SetNode -Version $Version
        }
    }
}

function Set_Node {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Version
    )
    if ($IsMacOS) {
        $Versions = (Get-ChildItem $NodeJsPath).Name
        if ($Versions -contains "${Version}") {
            $nodePath = "${NodeJsPath}/${Version}/bin"
            if (Test-Path -Path $nodePath) {
                WriteConfig -Name Node -Value $Version
                nvm alias default $Version
                $env:PATH = @($nodePath, $env:PATH) -join [io.path]::PathSeparator
                Set-Alias -Name node -Value $(Get-Command -Name node -Type Application | Select-Object -First 1).Source -Scope Global
            }
            else {
                WriteConfig -Name Node -Value $null
            }
            return
        }
    }
    elseif ($IsWindows) {
        $Versions = nvm.exe list | Select-String -Pattern '(\d+(.\d+){2})' | ForEach-Object { ($_.Matches).Value }
        if ($Versions -contains "${Version}") {
            WriteConfig -Name Node -Value $Version
            nvm.exe use $Version
            return
        }
    }
    WriteConfig -Name Node -Value $null
    WriteMessage -Type Warning -Message "Version '${Version}' of Node.js is not installed. Please install with nvm."
}

function Show_Node {
    $Version = ReadConfig -Name Node
    
    
    if ($Version) {
        WriteMessage_Version -Name 'Node.js' -Version $Version
    }
    else {
        WriteMessage_Version -Name 'Node.js' -Version 'Undefined'
    }
}

function Update_Npm {
    WriteMessage_Title -Action 'Updating' -Name 'npm'
    if (ExistCommand -Name npm) {
        WriteMessage_Subtitle -Action 'update' -With 'npm'
        npm install --global npm@latest
        WriteMessage_Version -Name 'Node.js' -Version (node --version)
        WriteMessage_Version -Name 'npm' -Version (npm --version)
        WriteMessage_Version -Name 'npx' -Version (npx --version)
    }
    else {
        WriteMessage_Fail -Action 'Updating'
    }
}

function Use_Node {
    Param(
        [ValidateSet(20, 21, 22, 23)]
        [Int16]
        $Version = 22
    )
    if ($IsMacOS) {
        $NodeVersion = $(nvm version $Version)
    }
    elseif ($IsWindows) {
        $NodeVersion = nvm.exe list | Select-String -Pattern "(${Version}(.\d+){2})" -AllMatches | ForEach-Object { ($_.Matches).Value } | Select-Object -First 1
    }
    if ($NodeVersion) {
        Set_Node -Version $NodeVersion
    }
}

function Command_WebPack {
    if (Test-Path -Path ($Path = [io.path]::Combine('.', 'node_modules', '.bin', 'webpack'))) {
        Invoke-Expression -Command "${Path} ${args}"
    }
    elseif (ExistCommand -Name webpack) {
        Invoke-Expression -Command ((Get-Command -Name webpack -Type Application).Source + " ${args}")
    }
    else {
        WriteMessage -Type Warning -Message 'Webpack is not available from this directory, nor is it installed globally.'
    }
}
New-Alias -Name webpack -Value WebpackCommand

Init_Node