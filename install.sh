#!/bin/zsh

# Clone note-sync repository
cd /tmp
rm -rf /tmp/sync-notes
git clone --depth=1 git@github.com:johnnyodonnell/sync-notes.git

# Add notes-sync bin to user home folder
mkdir ~/.sync-notes
rm -rf ~/.sync-notes/bin
cp -r /tmp/sync-notes/bin ~/.sync-notes/bin

# Create cron job for syncing notes
CRON_STRING="*/5 * * * *    $USER    /home/$USER/.sync-notes/bin/sync-notes.sh"
sudo touch /etc/cron.d/sync-notes
# https://askubuntu.com/a/103644/676338
echo $CRON_STRING > sudo tee /etc/cron.d/sync-notes

# Clean-up
rm -rf /tmp/sync-notes

