# Node.js
# =======
# https://nodejs.org/en

# Installation Management
# -----------------------

function Install-DF_Node {
    Write-DF_Message_Title -Action 'Installing' -Name 'Node.js'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'NVM'
        # nvm install
        nvm install --lts
        
    }
    elseif ($IsWindows) {
        $Latest = (((nvm list available) | Select-Object -Index 3).Split('|') | Select-Object -Index 2).Trim()
        Write-DF_Message_Subtitle -Action 'install' -With 'NVM'
        nvm.exe install $Latest
    }
    Update-DF_Npm
}

function Install-DF_Nvm {
    Write-DF_Message_Title -Action 'Installing' -Name 'NVM (Node Version Manager)'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install nvm'
    }
    elseif ($IsWindows) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install nvm'
    }
    if (Test-DF_Command -Name nvm) {
        Write-DF_Message_Version -Name 'NVM' -Version $(if ($IsMacOS) { nvm --version } elseif ($IsWindows) { nvm version })
    } 
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}

# Commands
# --------

function Initialize-DF_Node {
    if ($IsMacOS) {
        $Version = ReadConfig -Name Node
        if ($Version) {
            SetNode -Version $Version
        }
    }
}

function Set-DF_Node {
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
    Write-DF_Config -Name Node -Value $null
    Write-DF_Message -Type Warning -Message "Version '${Version}' of Node.js is not installed. Please install with nvm."
}

function Show-DF_Node {
    $Version = ReadConfig -Name Node
    
    
    if ($Version) {
        Write-DF_Message_Version -Name 'Node.js' -Version $Version
    }
    else {
        Write-DF_Message_Version -Name 'Node.js' -Version 'Undefined'
    }
}

function Update-DF_Npm {
    Write-DF_Message_Title -Action 'Updating' -Name 'npm'
    if (Test-DF_Command -Name npm) {
        Write-DF_Message_Subtitle -Action 'update' -With 'npm'
        npm install --global npm@latest
        Write-DF_Message_Version -Name 'Node.js' -Version (node --version)
        Write-DF_Message_Version -Name 'npm' -Version (npm --version)
        Write-DF_Message_Version -Name 'npx' -Version (npx --version)
    }
    else {
        Write-DF_Message_Fail -Action 'Updating'
    }
}

function Use-DF_Node {
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

function Invoke-DF_WebPack {
    if (Test-Path -Path ($Path = [io.path]::Combine('.', 'node_modules', '.bin', 'webpack'))) {
        Invoke-Expression -Command "${Path} ${args}"
    }
    elseif (Test-DF_Command -Name webpack) {
        Invoke-Expression -Command ((Get-Command -Name webpack -Type Application).Source + " ${args}")
    }
    else {
        Write-DF_Message -Type Warning -Message 'Webpack is not available from this directory, nor is it installed globally.'
    }
}
New-Alias -Name webpack -Value Invoke-DF_WebPack

Initialize-DF_Node