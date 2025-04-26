# Font
# ====

function InstallFont {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('FiraCode', 'Hack', 'Hasklig', 'JetBrainsMono', 'Monaspace')]
        [String]
        $Typeface
    )
    $FontFormat = 'otf'
    $Urn = "${Typeface}.zip"
    if ($IsMacOS) {
        $DestinationPath = "${HOME}/Library/Fonts/"
        $OutFile = Join-Path -Path $env:TMPDIR -ChildPath $Urn
        $TempPath = "${env:TMPDIR}${Typeface}/"
    }
    elseif ($IsWindows) {
        $DestinationPath = 'C:\Windows\Fonts\'
        $OutFile = Join-Path -Path $env:TEMP -ChildPath $Urn
        $TempPath = "${env:TEMP}${Typeface}\"
    }
    WriteMessage -Type Info -Inverse -Message 'Installing Typeface: ' -NoNewline
    switch ($Typeface) {
        'FiraCode' {
            WriteMessage -Type Info -Inverse -Message 'Fira Code by Nikita Prokopov'
            WriteMessage -Type Info -Message 'Downloading Fira Code typeface...'
            $Response = Invoke-RestMethod -Method Get -Uri https://api.github.com/repos/tonsky/FiraCode/releases/latest
            $Uri = $Response.assets.zipball_url
            Invoke-WebRequest -Uri $Uri -OutFile $OutFile
            if (Test-Path -Path $OutFile) {
                WriteMessage -Type Info -Message 'Installing Fira Code typeface...'
                if ($IsMacOS) {
                    $Output = unzip $OutFile **/*.$FontFormat -d $TempPath -o
                    Move-Item -Path ${TempPath}${FontFormat}/*.${FontFormat} -Destination $DestinationPath -Force
                }
                elseif ($IsWindows) {
                    Expand-Archive -Path $OutFile -DestinationPath $TempPath -Force
                    $Output = Get-ChildItem -Path ${TempPath}${FontFormat}\*.${FontFormat} | Select-Object { (New-Object -ComObject Shell.Application).Namespace(0x14).CopyHere($_.FullName) }
                }
                Remove-Item -Path $OutFile
            }
        }
        'Hack' {
            $FontFormat = 'ttf'
            WriteMessage -Type Info -Inverse -Message 'Hack by Chris Simpkins'
            WriteMessage -Type Info -Message 'Downloading Hack typeface'
            $Response = Invoke-RestMethod -Method Get -Uri https://api.github.com/repos/source-foundry/Hack/releases/latest
            $Uri = ($Response.assets | Where-Object { $_.name -match "^Hack-(.+)-${FontFormat}.zip$" }).browser_download_url
            Invoke-WebRequest -Uri $Uri -OutFile $OutFile
            if (Test-Path -Path $OutFile) {
                WriteMessage -Type Info -Message 'Installing Hack typeface...'
                if ($IsMacOS) {
                    $Output = unzip $OutFile *.${FontFormat} -d $TempPath -o
                    Move-Item -Path ${TempPath}*.${FontFormat} -Destination $DestinationPath -Force
                }
                elseif ($IsWindows) {
                    Expand-Archive -Path $OutFile -DestinationPath $TempPath -Force
                    $Output = Get-ChildItem -Path ${TempPath}*.${FontFormat} | Select-Object { (New-Object -ComObject Shell.Application).Namespace(0x14).CopyHere($_.FullName) }
                }
                Remove-Item -Path $OutFile
            }
        }
        'Hasklig' {
            WriteMessage -Type Info -Inverse -Message 'Hasklig by Ian Tuomi...'
            WriteMessage -Type Info -Message 'Downloading Hasklig typeface...'
            $Response = Invoke-RestMethod -Method Get -Uri https://api.github.com/repos/i-tu/Hasklig/releases?per_page=1
            # $Response = Invoke-RestMethod -Method Get -Uri https://api.github.com/repos/i-tu/Hasklig/releases/latest
            $Uri = $Response.assets.browser_download_url
            Invoke-WebRequest -Uri $Uri -OutFile $OutFile
            if (Test-Path -Path $OutFile) {
                WriteMessage -Type Info -Message 'Installing Hasklig typeface...'
                if ($IsMacOS) {
                    $Output = unzip $OutFile *.${FontFormat} -d $TempPath -o
                    Move-Item -Path ${TempPath}*.${FontFormat} -Destination $DestinationPath -Force
                }
                elseif ($IsWindows) {
                    Expand-Archive -Path $OutFile -DestinationPath $TempPath -Force
                    $Output = Get-ChildItem -Path "${TempPath}*.${FontFormat}" | Select-Object { (New-Object -ComObject Shell.Application).Namespace(0x14).CopyHere($_.FullName) }
                }
                Remove-Item -Path $OutFile
            }
        }
        'JetBrainsMono' {
            $FontFormat = 'ttf'
            WriteMessage -Type Info -Inverse -Message 'JetBrains Mono by Philipp Nurullin...'
            WriteMessage -Type Info -Message 'Downloading JetBrains Mono typeface...'
            $Uri = 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip'
            Invoke-WebRequest -Uri $Uri -OutFile $OutFile
            if (Test-Path -Path $OutFile) {
                WriteMessage -Type Info -Message 'Installing JetBrains Mono typeface...'
                if ($IsMacOS) {
                    $Output = unzip $OutFile *.${FontFormat} -d $TempPath -o
                    Move-Item -Path ${TempPath}*.${FontFormat} -Destination $DestinationPath -Force
                }
                elseif ($IsWindows) {
                    Expand-Archive -Path $OutFile -DestinationPath $TempPath -Force
                    $Output = Get-ChildItem -Path "${TempPath}*.${FontFormat}" | Select-Object { (New-Object -ComObject Shell.Application).Namespace(0x14).CopyHere($_.FullName) }
                }
                Remove-Item -Path $OutFile
            }
        }
        'Monaspace' {
            WriteMessage -Type Info -Inverse -Message 'Monaspace by GitHub...'
            WriteMessage -Type Info -Message 'Downloading GitHub Monaspace family of typefaces...'
            $Uri = 'https://github.com/githubnext/monaspace/releases/download/v1.000/monaspace-v1.000.zip'
            Invoke-WebRequest -Uri $Uri -OutFile $OutFile
            if (Test-Path -Path $OutFile) {
                WriteMessage -Type Info -Message 'Installing GitHub Monaspace family of typefaces...'
                if ($IsMacOS) {
                    $Output = unzip $OutFile *.${FontFormat} -d $TempPath -o
                    Move-Item -Path ${TempPath}*.${FontFormat} -Destination $DestinationPath -Force
                }
                elseif ($IsWindows) {
                    Expand-Archive -Path $OutFile -DestinationPath $TempPath -Force
                    $Output = Get-ChildItem -Path "${TempPath}*.${FontFormat}" | Select-Object { (New-Object -ComObject Shell.Application).Namespace(0x14).CopyHere($_.FullName) }
                }
                Remove-Item -Path $OutFile
            }
        }
        Default {
            return
        }
    }
    Remove-Item -Path $TempPath -Recurse -Force
}