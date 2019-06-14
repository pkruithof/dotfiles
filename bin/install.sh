#!/usr/bin/env bash

set -e

DOTFILES_ROOT=~/.dotfiles

source ${DOTFILES_ROOT}/lib/run.sh
source ${DOTFILES_ROOT}/lib/io.sh
source ${DOTFILES_ROOT}/lib/brew.sh
source ${DOTFILES_ROOT}/lib/ruby.sh

# install XCode developer tools
xcode-select --install || true

brew_install
gem_install
copy_ssh_key
copy_hosts_file
mirror_files
install_git_config
enable_zsh
compile_zsh_plugins
