#!/usr/bin/env bash

# This file reserves a space for running updates.

echo "The ability to update VIMSetup  will come at a future date."
echo ''

# TODO: Create the ability to update the snippets without overwriting the user's additions to the snippets.

git subcommand update

git subcommand init

# Update Coc.nvim
# vim -c 'CocUpdateSync|q'
