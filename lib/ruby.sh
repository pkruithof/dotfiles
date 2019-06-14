gem_install () {
  e_header "Installing Bundler"
  gem install bundler

  e_header "Installing gems"
  bundle install --gemfile ${DOTFILES_ROOT}/macos/Gemfile
}

gem_update () {
  e_header "Updating gems"
  bundle update --gemfile ${DOTFILES_ROOT}/macos/Gemfile
}
