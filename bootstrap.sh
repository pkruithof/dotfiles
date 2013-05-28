#!/bin/bash
cd "`dirname $0`"

# Pull down the latest changes
git pull

# Check out submodules
git submodule --quiet update --init

function doIt() {
    rsync -av \
      --exclude ".git/" \
      --exclude "git" \
      --exclude ".DS_Store" \
      --exclude "bootstrap.sh" \
      --exclude "README.md" \
      . ~

    # copy git files
    cp -R git/config ~/.gitconfig
    cp -R git/ignore ~/.gitignore
    cp -R git/attributes ~/.gitattributes

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

#if [[ $ZSH_NAME ]]; then
#  source ~/.zshrc
#else
#  source ~/.bashrc
#fi