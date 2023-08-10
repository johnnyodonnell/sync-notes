#!/bin/zsh

# From https://unix.stackexchange.com/a/7012/227191
IFS=$'\n'
set -f

for dir in $(cat ~/.sync-notes/dirs); do
    ~/.sync-notes/bin/pull-notes.sh

    if [ "$(git -C $dir status --porcelain)" ]; then
        ~/.sync-notes/bin/commit-push-notes.sh $dir
    fi
done

