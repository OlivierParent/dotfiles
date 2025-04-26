# macOS
# =====
# https://www.apple.com/macos/

if ($IsMacOS) {

    # Utility functions
    # -----------------

    function Restart_SshAgent {
        WriteMessage_Title -Action 'Restarting' -Name 'SSH Agent'
        sh -c 'launchctl stop /System/Library/LaunchAgents/org.openbsd.ssh-agent'
        sh -c 'launchctl start /System/Library/LaunchAgents/org.openbsd.ssh-agent'
    }

}