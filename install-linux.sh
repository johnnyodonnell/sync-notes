#!/bin/bash

# Clone note-sync repository
cd /tmp
rm -rf /tmp/sync-notes
git clone --depth=1 git@github.com:johnnyodonnell/sync-notes.git

# Remove old cron file
CRON_FILENAME=sync-notes-$USER
sudo rm /etc/cron.d/$CRON_FILENAME

# Add notes-sync bin to user home folder
mkdir -p ~/.sync-notes
rm -rf ~/.sync-notes/bin
cp -r /tmp/sync-notes/bin ~/.sync-notes/bin

# Create cron job for syncing notes
read -r -d '' CRON_FILE << EOM
* * * * * $USER ~/.sync-notes/bin/sync-notes.sh
EOM

sudo touch /etc/cron.d/$CRON_FILENAME

# Need quotes to prevent globbing
echo "$CRON_FILE" | sudo tee /etc/cron.d/$CRON_FILENAME

# Clean-up
rm -rf /tmp/sync-notes

