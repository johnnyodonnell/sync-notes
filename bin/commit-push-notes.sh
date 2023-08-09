#!/bin/zsh

git -C $1 pull

DATE=$(date "+%Y-%m-%d")

git -C $1 add .
git -C $1 commit -m "Notes from $DATE"
git -C $1 push

