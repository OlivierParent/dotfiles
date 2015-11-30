$internetSettingsRegKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$currentProxyServer     = ""
$proxyServer            = "http://proxy.arteveldehs.be:8080"
$noProxy                = "localhost,0.0.0.0,127.0.0.1,.local"
$user                   = "User"

Write-Host "======================================================="
Write-Host "==  Artevelde University College Ghent Proxy Toggle  =="
Write-Host "======================================================="
Write-Host "1. Retrieve the proxy server from the internet options …"
$currentProxyServer = Get-ItemProperty -path $internetSettingsRegKey ProxyServer -ErrorAction SilentlyContinue

if ([string]::IsNullOrEmpty($currentProxyServer)) {
    Write-Host "2. Internet options: Proxy is currently disabled"
    Set-ItemProperty -path $internetSettingsRegKey ProxyEnable -value 1
    Set-ItemProperty -path $internetSettingsRegKey ProxyServer -value $proxyServer
    Write-Host "3. Internet options: Proxy is now enabled"
    [Environment]::SetEnvironmentVariable("HTTP_PROXY"         , $proxyServer, $user)
    [Environment]::SetEnvironmentVariable("HTTPS_PROXY"        , $proxyServer, $user)
    [Environment]::SetEnvironmentVariable("FTP_PROXY"          , $proxyServer, $user)
    [Environment]::SetEnvironmentVariable("NO_PROXY"           , $noProxy    , $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_HTTP_PROXY" , $proxyServer, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_HTTPS_PROXY", $proxyServer, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_FTP_PROXY"  , $proxyServer, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_NO_PROXY"   , $noProxy    , $user)
    Write-Host "4. Environment variables: Proxy is now enabled"
} else {
    Write-Host "2. Internet options: Proxy is currently enabled, server: " + $currentProxyServer
    Set-ItemProperty    -path $internetSettingsRegKey ProxyEnable -value 0
    Remove-ItemProperty -path $internetSettingsRegKey -name ProxyServer
    Write-Host "3. Internet options: Proxy is now disabled"
    [Environment]::SetEnvironmentVariable("HTTP_PROXY"         , $null, $user)
    [Environment]::SetEnvironmentVariable("HTTPS_PROXY"        , $null, $user)
    [Environment]::SetEnvironmentVariable("FTP_PROXY"          , $null, $user)
    [Environment]::SetEnvironmentVariable("NO_PROXY"           , $null, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_HTTP_PROXY" , $null, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_HTTPS_PROXY", $null, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_FTP_PROXY"  , $null, $user)
    [Environment]::SetEnvironmentVariable("VAGRANT_NO_PROXY"   , $null, $user)
    Write-Host "4. Environment variables: Proxy is now disabled"
}
Write-Host "======================================================="