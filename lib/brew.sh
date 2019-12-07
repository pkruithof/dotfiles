brew_install () {
  e_header "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew_update
}

brew_update() {
  e_header "Updating Homebrew"

  e_info "==> installing missing formulae"
  brew bundle --file="${DOTFILES_ROOT}/macos/Brewfile"

  e_info "==> upgrading existing formulae"
  brew upgrade

  # Remove outdated versions from the Cellar
  e_info "==> cleaning up"
  brew cleanup
}
