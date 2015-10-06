#!/bin/sh

rm -Rf /Applications/Android\ Studio.app
rm -Rf ~/Library/Preferences/AndroidStudio*
rm ~/Library/Preferences/com.google.android.studio.plist
rm -Rf ~/Library/Application\ Support/AndroidStudio*
rm -Rf ~/Library/Logs/AndroidStudio*
rm -Rf ~/Library/Caches/AndroidStudio*

# Projects
rm -Rf ~/AndroidStudioProjects

# Gradle
rm -Rf ~/.gradle

# Android Virtual Devices
rm -Rf ~/.android

# Android SDK
rm -Rf ~/Library/Android*