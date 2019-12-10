# Test whether a command exists
# $1 - cmd to test
type_exists() {
  if type -f $1 > /dev/null 2>&1; then
    return 0
  fi
  return 1
}

dotfile () {
  local from="${DOTFILES_ROOT}/${1}"
  local to="${HOME}/${2}"

  if [[ ! -f ${from} ]]; then
    die "${from} does not exist"
  fi

  # Force create/replace the symlink.
  ln -fs "${from}" "${to}"
  e_info "==> ${from} => ${to}"
}

copy () {
  local from="${DOTFILES_ROOT}/${1}"
  local to="${HOME}/${2}"

  if [[ ! -f ${from} ]]; then
    die "${from} does not exist"
  fi

  # create/replace the file.
  cp -f "${from}" "${to}"
  e_info "==> ${from} => ${to}"
}

update_repo () {
  e_header "Updating dotfiles project"
  e_info "==> pulling latest changes from repo"
  git pull --rebase origin master
  e_success "==> done"
}

mirror_files () {
  e_header "Symlinking dotfiles into home directory"

  if ! confirm 'Warning: This step may overwrite your existing dotfiles.'; then
    e_warning "==> skipped symlinking of dotfiles"
  else
    # ZSH files
    mkdir -p "${HOME}/.zsh"
    dotfile "zsh/aliases"         ".zsh/aliases"
    dotfile "zsh/completion"      ".zsh/completion"
    dotfile "zsh/env"             ".zshenv"
    dotfile "zsh/functions"       ".zsh/functions"
    dotfile "zsh/history"         ".zsh/history"
    dotfile "zsh/input"           ".zsh/input"
    dotfile "zsh/paths"           ".zsh/paths"
    dotfile "zsh/zshrc"           ".zshrc"

    # Bin
    mkdir -p "${HOME}/bin"
    dotfile "bin/update.sh"       "bin/dotfiles"

    # Git
    copy    "git/config"          ".gitconfig"
    dotfile "git/attributes"      ".gitattributes"
    dotfile "git/ignore"          ".gitignore"

    # Curl
    dotfile "curl/rc"             ".curlrc"

    # Screen
    dotfile "screen/rc"           ".screenrc"

    # Ruby
    dotfile "ruby/gemrc"          ".gemrc"

    # SSH
    mkdir -p "${HOME}/.ssh"
    dotfile "ssh/config"          ".ssh/config"
  fi
}

copy_ssh_key () {
  e_header "Installing ssh key"

  if [[ ! -f "${HOME}/.ssh/id_rsa" && ! -L "${HOME}/.ssh/id_rsa" ]]; then
    if seek_confirmation 'No existing SSH keypair found, should I install from backup?'; then
      SSH_DIR="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Settings/ssh"
      mkdir -p "${HOME}/.ssh"
      cp "${SSH_DIR}/id_rsa" "${HOME}/.ssh/id_rsa"
      cp "${SSH_DIR}/id_rsa.pub" "${HOME}/.ssh/id_rsa.pub"
      chmod 600 "${HOME}/.ssh/id_rsa" "${HOME}/.ssh/id_rsa.pub"
      e_info "==> symlinked SSH keypair from backup"
    fi
  fi
}

copy_hosts_file () {
  e_header "Add custom hosts to /etc/hosts"

  HEADER="### CUSTOM HOSTS ###\n\n"
  if ! grep "${HEADER}" /etc/hosts; then
    hosts=$(cat "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Settings/etc/hosts")
    echo -e "\n\n${HEADER}" | (sudo sh -c 'tee -a /etc/hosts') > /dev/null 2>&1
    echo -e "${hosts}\n" | (sudo sh -c 'tee -a /etc/hosts') > /dev/null 2>&1
    e_info "==> added hosts from backup to /etc/hosts"
  fi
}

install_git_config () {
  e_header "Configuring git"

  GITRC_FILE="${HOME}/.gitrc"
  if [[ ! -f ${GITRC_FILE} ]]; then
    if seek_confirmation "Would you like to specify your git username/email address?"; then
      read -p "username: " username
      read -p "email: " email
      echo -e "git config --global user.name \"${username}\"\ngit config --global user.email \"${email}\"\n" > ${GITRC_FILE}
    else
      echo -e "# put 'git config' commands here\n" > ${GITRC_FILE}
    fi
    chmod +x ${GITRC_FILE}
  fi

  source ${GITRC_FILE}

  # Delete Git's official completions to allow Zsh's official Git completions to work.
  # Git ships with really bad Zsh completions. Zsh provides its own completions
  # for Git, and they are much better.
  # https://github.com/Homebrew/homebrew-core/issues/33275#issuecomment-432528793
  # https://twitter.com/OliverJAsh/status/1068483170578964480
  # Unfortunately it's not possible to install Git without completions (since
  # https://github.com/Homebrew/homebrew-core/commit/f710a1395f44224e4bcc3518ee9c13a0dc850be1#r30588883),
  # so in order to use Zsh's own completions, we must delete Git's completions.
  # This is also necessary for hub's Zsh completions to work:
  # https://github.com/github/hub/issues/1956.
  GIT_ZSH_COMPLETIONS_FILE_PATH="$(brew --prefix)/share/zsh/site-functions/_git"
  if [[ -f ${GIT_ZSH_COMPLETIONS_FILE_PATH} ]]; then
    rm ${GIT_ZSH_COMPLETIONS_FILE_PATH}
  fi
}

enable_zsh () {
  zshpath=$(which zsh)

  # make sure zsh is listed in shells
  if ! grep -q ${zshpath} /etc/shells; then
    e_info "==> registering zsh shell"
    echo ${zshpath} | sudo tee -a /etc/shells
  fi

  if [[ ! ${SHELL} = ${zshpath} ]]; then
    e_info "==> changing shell to zsh"
    chsh -s ${zshpath}
  fi
}

compile_zsh_plugins () {
  e_info "==> compiling zsh plugins"
  antibody bundle < ${DOTFILES_ROOT}/zsh/plugins > ~/.zsh/plugins
}
