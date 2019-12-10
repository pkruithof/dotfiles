gem_install () {
  e_header "Installing Bundler"
  "$(brew --prefix ruby)/bin/gem" install bundler

  e_header "Installing gems"
  "$(brew --prefix ruby)/bin/bundle" install --gemfile ${DOTFILES_ROOT}/macos/Gemfile
}

gem_update () {
  e_header "Updating gems"
  bundle update --gemfile ${DOTFILES_ROOT}/macos/Gemfile
}
