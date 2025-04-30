# Rust
# ====
# https://www.rust-lang.org/

# Installation Management
# -----------------------

function Install-DF_Rust {
    Write-DF_Message_Title -Action 'Installing' -Name 'Rust'
    if ($IsMacOS) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install rust'
    }
    elseif ($IsWindows) {
        Write-DF_Message_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install rust'
    }
    if (Test-DF_Command -Name rustc) {
        Write-DF_Message_Version -Name 'Rust' -Version $Version(rustc --version)
    } 
    else {
        Write-DF_Message_Fail -Action 'Installation'
    }
}