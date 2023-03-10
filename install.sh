#!/bin/zsh

# Clone note-sync repository
cd /tmp
rm -rf /tmp/notes-sync
git clone --depth=1 git@github.com:johnnyodonnell/notes-sync.git

# Add notes-sync bin to user home folder
mkdir ~/.notes-sync
rm -rf ~/.notes-sync/bin
cp /tmp/notes-sync/bin ~/.notes-sync/bin

# Create cron job for syncing notes
CRON_STRING="*/5 * * * *    $USER    /home/$USER/.notes-sync/bin/notes-sync.sh"
sudo touch sync-notes
sudo echo $CRON_STRING > sync-notes

