#!/bin/zsh

# Clone note-sync repository
cd /tmp
rm -rf /tmp/sync-notes
git clone --depth=1 git@github.com:johnnyodonnell/sync-notes.git

# Add notes-sync bin to user home folder
mkdir ~/.sync-notes
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
    <integer>300</integer>
</dict>
</plist>
EOM
sudo touch /Library/LaunchDaemons/$LAUNCHD_NAME.plist
echo $LAUNCHD_FILE | sudo tee /Library/LaunchDaemons/$LAUNCHD_NAME.plist
sudo launchctl load -w /Library/LaunchDaemons/$LAUNCHD_NAME.plist

# Clean-up
rm -rf /tmp/sync-notes

