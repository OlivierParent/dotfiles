#!/bin/sh
sudo apt update
sudo apt install '^libssl1.0.[0-9]$' libunwind8 -y
wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.6/powershell-7.0.0-preview.6-linux-arm32.tar.gz
mkdir ~/powershell
tar -xvf ./powershell-7.0.0-preview.6-linux-arm32.tar.gz -C ~/powershell
sudo ~/powershell/pwsh -c New-Item -ItemType SymbolicLink -Path "/usr/bin/pwsh" -Target "\$PSHOME/pwsh" -Force