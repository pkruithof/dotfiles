#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"

# Pull down the latest changes
git pull

# Check out submodules
git submodule --quiet update --init

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

if [[ $BASH ]]; then
  source ~/.bash_profile
elif [[ $ZSH_NAME ]]; then
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/*; do
    if [[ `basename "${rcfile}"` != "README.md" ]]; then
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
  done
  source ~/.zsh_profile
fi