# load oh-my-zsh
source "$HOME/.zsh/config"

typeset -ga sources
sources+="$HOME/.zsh/input"
sources+="$HOME/.environment"
sources+="$HOME/.aliases"
sources+="$HOME/.exports"
sources+="$HOME/.functions"

# Check for a system-specific file
[[ -f "$HOME/.systemrc" ]] && sources+="$HOME/.systemrc"

# use .localrc for settings specific to one system
[[ -f "$HOME/.localrc" ]] && sources+="$HOME/.localrc"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && sources+="$HOME/.rvm/scripts/rvm"

# plugins
sources+="$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# try to include all sources
foreach file (`echo $sources`)
  if [[ -e $file ]]; then
    source $file
  fi
end

# Remove duplicates (copied from http://unix.stackexchange.com/a/14896)
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
export PATH
