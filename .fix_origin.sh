#!/bin/bash

export PATH=$PATH:$HOME/bin

NEW_ORIGIN="nate@digit.ndj.la:dotfiles.git"

# Move to new origin if old one found
ORIGIN_URL=$(dfm url origin)
if [[ $ORIGIN_URL != "$NEW_ORIGIN" ]]; then
    echo -n "Moving remote to $NEW_ORIGIN..."
    dfm remote set-url origin $NEW_ORIGIN
    echo "done."
fi
