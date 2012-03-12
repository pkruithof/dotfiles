#!/bin/bash

cd "$(dirname "$0")"

# Pull down the latest changes
git pull origin master

# Check out submodules
git submodule --quiet update --init

function doIt() {
  rsync -Cav --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
source ~/.bash_profile