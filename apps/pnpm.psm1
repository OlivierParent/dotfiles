# pnpm
# ====
# https://pnpm.io/

# Installation Management
# -----------------------

function Install-DF_Pnpm {
    Write-DF_Message_Title -Action 'Installing' -Name 'pnpm'
    npx get-pnpm
    if (Test-DF_Command -Name pnpm) {
        Write-DF_Message_Version -Name 'pnpm' -Version (pnpm --version)
    }
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}

if (Test-DF_Command -Name pnpm) {

    # Commands
    # --------

    # Help
    # ----

    function Show-DF_PnpmWeb {
        Start-DF_Browser https://pnpm.io/
    }

}