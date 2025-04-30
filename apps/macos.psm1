# macOS
# =====
# https://www.apple.com/macos/

if ($IsMacOS) {

    # Utility functions
    # -----------------

    function Restart-DF_SshAgent {
        Write-DF_Message_Title -Action 'Restarting' -Name 'SSH Agent'
        sh -c 'launchctl stop /System/Library/LaunchAgents/org.openbsd.ssh-agent'
        sh -c 'launchctl start /System/Library/LaunchAgents/org.openbsd.ssh-agent'
    }

}