#!/usr/bin/env bash

set -e

DOTFILES_ROOT=~/.dotfiles

source ${DOTFILES_ROOT}/lib/run.sh
source ${DOTFILES_ROOT}/lib/io.sh
source ${DOTFILES_ROOT}/lib/brew.sh
source ${DOTFILES_ROOT}/lib/ruby.sh

#brew_update
#gem_update
mirror_files
install_git_config
compile_zsh_plugins
