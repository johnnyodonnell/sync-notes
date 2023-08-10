#!/bin/zsh

# Clone note-sync repository
cd /tmp
rm -rf /tmp/sync-notes
git clone --depth=1 git@github.com:johnnyodonnell/sync-notes.git

# Add notes-sync bin to user home folder
mkdir -p ~/.sync-notes
rm -rf ~/.sync-notes/bin
cp -r /tmp/sync-notes/bin ~/.sync-notes/bin

# Create cron job (LaunchD in Mac) for syncing notes
LAUNCHD_NAME="com.sync-notes.sync-notes"
read -r -d '' LAUNCHD_FILE << EOM
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$LAUNCHD_NAME</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/$USER/.sync-notes/bin/sync-notes.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>60</integer>
</dict>
</plist>
EOM
touch ~/Library/LaunchAgents/$LAUNCHD_NAME.plist
echo $LAUNCHD_FILE > ~/Library/LaunchAgents/$LAUNCHD_NAME.plist
launchctl unload ~/Library/LaunchAgents/$LAUNCHD_NAME.plist
launchctl load ~/Library/LaunchAgents/$LAUNCHD_NAME.plist

# Clean-up
rm -rf /tmp/sync-notes

