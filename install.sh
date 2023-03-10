#!/bin/zsh

# Clone note-sync repository
cd /tmp
rm -rf /tmp/sync-notes
git clone --depth=1 git@github.com:johnnyodonnell/sync-notes.git

# Add notes-sync bin to user home folder
mkdir ~/.sync-notes
rm -rf ~/.sync-notes/bin
cp /tmp/sync-notes/bin ~/.sync-notes/bin

# Create cron job for syncing notes
CRON_STRING="*/5 * * * *    $USER    /home/$USER/.sync-notes/bin/sync-notes.sh"
sudo touch sync-notes
sudo echo $CRON_STRING > sync-notes

# Clean-up
rm -rf /tmp/sync-notes

