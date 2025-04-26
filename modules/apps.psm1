# Installation Management
# -----------------------

function Install_ {
    $Output = @()
    $Output += Get-Command -Name Install_* -CommandType Function | Where-Object { $_.Version -eq '0.0' -and $_.Name -ne 'Install_' }
    $Output += Get-Command -Name Reinstall_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output += Get-Command -Name Reset_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output | Format-Table -Property Name
}
New-Alias -Name install -Value Install_

function Uninstall_ {
    $Output = @()
    $Output += Get-Command -Name Uninstall_* -CommandType Function | Where-Object { $_.Version -eq '0.0' -and $_.Name -ne 'Uninstall_' }
    $Output += Get-Command -Name Remove_* -CommandType Function | Where-Object { $_.Version -eq '0.0' }
    $Output | Format-Table -Property Name
}
New-Alias -Name uninstall -Value Uninstall_

function Update_ {
    $Output = @()
    $Output += Get-Command -Name Update_* -CommandType Function | Where-Object { $_.Version -eq '0.0' -and $_.Name -ne 'Update_' } | Format-Table -Property Name
    $Output | Format-Table -Property Name
}
New-Alias -Name update -Value Update_

# Help
# ----

function Open_ {
    $Output = @()
    $Output += Get-Command -Name Open_* -CommandType Function | Where-Object { $_.Version -eq '0.0' -and $_.Name -ne 'Open_' }
    $Output | Format-Table -Property Name
}
New-Alias -Name open -Value Open_
