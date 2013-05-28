# load oh-my-zsh
source "$HOME/.zsh/config"

typeset -ga sources
sources+="$HOME/.zsh/input"
sources+="$HOME/.common/environment"
sources+="$HOME/.common/aliases"
sources+="$HOME/.common/exports"
sources+="$HOME/.common/functions"

# Check for a system specific file
systemFile=`uname -s | tr "[:upper:]" "[:lower:]"`
sources+="$HOME/.system/$systemFile"

# use .localrc for settings specific to one system
[[ -f "$HOME/.localrc" ]] && sources+="$HOME/.localrc"

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
