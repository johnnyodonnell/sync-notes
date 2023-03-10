#!/bin/zsh

# From https://unix.stackexchange.com/a/7012/227191
IFS=$'\n'
set -f

for dir in $(cat ~/.notes-sync/dirs); do
    if [ -z "$(git -C $dir status --porcelain)" ]; then
        ~/.notes-sync/bin/commit-push-notes.sh $dir
    fi
done

