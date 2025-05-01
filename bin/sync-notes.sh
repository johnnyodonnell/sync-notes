#!/bin/zsh

# From https://unix.stackexchange.com/a/7012/227191
IFS=$'\n'
set -f

for dir in $(cat ~/.sync-notes/dirs); do
    [[ -z "$dir" ]] && continue # Skip if $dir is empty

    ~/.sync-notes/bin/pull-notes.sh "$dir"

    if [ "$(git -C $dir status --porcelain)" ]; then
        ~/.sync-notes/bin/commit-push-notes.sh "$dir"
    fi
done

