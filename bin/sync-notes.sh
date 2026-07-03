#!/bin/zsh

# Split only on newlines so paths with spaces work
IFS=$'\n'

# A glob matching nothing (e.g. an empty ~/Notes/*) should expand to nothing
# rather than erroring out.
setopt null_glob

sync_repo() {
    dir=$1

    ~/.sync-notes/bin/pull-notes.sh "$dir"

    if [ "$(git -C "$dir" status --porcelain)" ]; then
        ~/.sync-notes/bin/commit-push-notes.sh "$dir"
    fi
}

for entry in $(cat ~/.sync-notes/dirs); do
    [[ -z "$entry" ]] && continue # Skip if $entry is empty

    # Expand a leading ~ to the home directory
    entry=${entry/#\~/$HOME}

    # Expand globs (e.g. ~/Notes/*). ${~entry} enables filename generation on
    # the value. A plain path with no glob characters expands to itself.
    for dir in ${~entry}; do
        # Only sync directories that are git repos (.git is a dir in a normal
        # clone, a file in a worktree/submodule).
        [[ -e "$dir/.git" ]] && sync_repo "$dir"
    done
done
