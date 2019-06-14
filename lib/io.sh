confirm () {
  if seek_confirmation "$@"; then
    return 0
  else
    return 1
  fi
}

# Ask for confirmation before proceeding
seek_confirmation () {
  # only do this in interactive shell
  if [[ -t 0 ]]; then
    printf "\n"
    e_warning "$@"
    read -p "Continue? (y/n) " -n 1
    printf "\n"
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      return 0
    fi
  fi

  return 1
}

# Header logging
e_header() {
  printf "\n$(tput setaf 4)%s$(tput sgr0)\n" "$@"
}

# Info logging
e_info() {
  printf "$(tput setaf 7)%s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
  printf "$(tput setaf 64)✓ %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
  printf "$(tput setaf 136)! %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
  printf "$(tput setaf 1)x %s$(tput sgr0)\n" "$@"
}

# Log error and exit
die () {
  e_error "$1"
  echo ''
  exit
}
