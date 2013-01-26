#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"

# Pull down the latest changes
# git pull

# Check out submodules
# git submodule --quiet update --init

function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
    # Sync vim colors
    cp .vim/colors/*/colors/*.vim ~/.vim/colors/
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
