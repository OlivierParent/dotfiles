# Browsers
# ========

# Commands
# --------

function Start-DF_Browser {
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Uri,
        [Switch]
        [Alias('https')]
        $Secure,
        [Switch]
        [Alias('b')]
        $Blisk,
        [Switch]
        [Alias('c')]
        $Chrome,
        [Switch]
        [Alias('cx')]
        $ChromeCanary,
        [Switch]
        [Alias('e')]
        $Edge,
        [Switch]
        [Alias('f')]
        $Firefox,
        [Switch]
        [Alias('fx')]
        $FirefoxDeveloperEdition,
        [Switch]
        [Alias('o')]
        $Opera,
        [Switch]
        [Alias('ox')]
        $OperaDeveloper,
        [Switch]
        [Alias('s')]
        $Safari,
        [Switch]
        [Alias('sx')]
        $SafariTechnologyPreview,
        [Switch]
        [Alias('v')]
        $Vivaldi
    )
    if (! ($Uri -match '^http(s)?://')) {
        $Protocol = 'http';
        if ($Secure) {
            $Protocol += 's'
        }
        $Uri = "${Protocol}://${Uri}"
    }
    if ($IsMacOS) {
        $Command = "open ${Uri}"
        if ($Blisk) {
            $Command += ' -a Blisk'
        }
        elseif ($Chrome) {
            $Command += ' -a "Google Chrome"'
        }
        elseif ($ChromeCanary) {
            $Command += ' -a "Google Chrome Canary"'
        }
        elseif ($Firefox) {
            $Command += ' -a Firefox'
        }
        elseif ($FirefoxDeveloperEdition) {
            $Command += ' -a "Firefox Developer Edition"'
        }
        elseif ($Opera) {
            $Command += ' -a Opera'
        }
        elseif ($OperaDeveloper) {
            $Command += ' -a "Opera Developer"'
        }
        elseif ($Safari) {
            $Command += ' -a Safari'
        }
        elseif ($SafariTechnologyPreview) {
            $Command += ' -a "Safari Technology Preview"'
        }
        elseif ($Vivaldi) {
            $Command += ' -a Vivaldi'
        }
        Invoke-Expression -Command $Command
    }
    elseif ($IsWindows) {
        if ($Blisk) {
            $Browser = 'blisk.exe'
        }
        elseif ($Chrome) {
            $Browser = "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
        }
        elseif ($ChromeCanary) {
            $Browser = "$HOME\AppData\Local\Google\Chrome SxS\Application\chrome.exe"
        }
        elseif ($Edge) {
            $Command = "microsoft-edge:${Uri}"
        }
        elseif ($Firefox) {
            $Browser = "${env:ProgramFiles}\Mozilla Firefox\firefox.exe"
        }
        elseif ($FirefoxDeveloperEdition) {
            $Browser = "${env:ProgramFiles}\Firefox Developer Edition\firefox.exe"
        }
        elseif ($Opera) {
            $Browser = "${env:ProgramFiles(x86)}\Opera\launcher.exe"
        }
        elseif ($OperaDeveloper) {
            $Browser = "${env:ProgramFiles(x86)}\Opera developer\launcher.exe"
        }
        elseif ($Vivaldi) {
            $Browser = 'vivaldi.exe'
        }
        else {
            $Command = $Uri;
        }
        if ($Browser) {
            Start-Process -FilePath $Browser -ArgumentList $Uri
        }
        elseif ($Command) {
            Start-Process -FilePath $Command
        }
    }
}
New-Alias -Name b -Value Start-DF_Browser