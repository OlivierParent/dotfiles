# Commandlets
# ===========

function Show-DF_All {
    $Output = @()
    $Output += Get-Command -Name *-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output | Format-Table -Property Name
}
New-Alias -Name all -Value Show-DF_All


# Installation Management
# -----------------------

function Show-DF_Install {
    $Output = @()
    $Output += Get-Command -Name Install-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output += Get-Command -Name Reinstall-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output += Get-Command -Name Reset-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output | Format-Table -Property Name
}
New-Alias -Name install -Value Show-DF_Install

function Show-DF_Uninstall {
    $Output = @()
    $Output += Get-Command -Name Uninstall-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output += Get-Command -Name Remove-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output | Format-Table -Property Name
}
New-Alias -Name uninstall -Value Show-DF_Uninstall

function Show-DF_Update {
    $Output = @()
    $Output += Get-Command -Name Update-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' } | Format-Table -Property Name
    $Output | Format-Table -Property Name
}
New-Alias -Name update -Value Show-DF_Update

# Help
# ----

function Show-DF_Show {
    $Output = @()
    $Output += Get-Command -Name Show-DF_* -CommandType Function | Where-Object { $_.Version -eq '0.0' -and $_.Name -ne 'Show-DF_Show' }
    $Output | Format-Table -Property Name
}
New-Alias -Name show -Value Show-DF_Show
