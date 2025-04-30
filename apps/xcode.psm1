# Apple Xcode
# ===========
# https://developer.apple.com/xcode/

if ($IsMacOS) {

    # Installation Management
    # -----------------------

    function Install-DF_Xcode {
        Write-DF_Message_Title -Action 'Reinstalling' -Name 'Xcode'
        sh -c 'sudo rm -rf $(xcode-select -print-path)'
        sh -c 'xcode-select --install'
    }

}
