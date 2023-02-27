#!/bin/bash

# Move to new origin if old one found
ORIGIN_URL=$(dfm url origin)
if [[ $ORIGIN_URL != "git@github.com:justone/df.git" ]]; then
    echo -n "Moving remote to github.com..."
    dfm remote set-url origin git@github.com:justone/df.git
    echo "done."
fi
