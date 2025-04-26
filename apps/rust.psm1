# Rust
# ====
# https://www.rust-lang.org/

# Installation Management
# -----------------------

function Install_Rust {
    WriteMessage_Title -Action 'Installing' -Name 'Rust'
    if ($IsMacOS) {
        WriteMessage_Subtitle -Action 'install' -With 'Homebrew'
        bash -c 'brew install rust'
    }
    elseif ($IsWindows) {
        WriteMessage_Subtitle -Action 'install' -With 'Scoop'
        cmd /c 'scoop install rust'
    }
    if (ExistCommand -Name rustc) {
        WriteMessage_Version -Name 'Rust' -Version $Version(rustc --version)
    } 
    else {
        WriteMessage_Fail -Action 'Installation'
    }
}