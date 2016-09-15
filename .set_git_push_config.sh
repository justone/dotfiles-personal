#!/bin/bash

# if new enough version of git is found, set the push default to simple
GITVER=$(git version | head -n 1 | awk '{ print $3 }' | cut -d. -f1)
if [[ $GITVER = 2 ]]; then
    if ! grep simple ~/.gitconfig.local &>/dev/null; then
        echo "Git version 2 found, setting push default to 'simple'"
        git config --file ~/.gitconfig.local push.default simple
    fi
fi
