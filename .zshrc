# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# first include of the environment
source "${ZDOTDIR:-$HOME}/.common/environment"

typeset -ga sources
sources+="${ZDOTDIR:-$HOME}/.zsh/input"
sources+="${ZDOTDIR:-$HOME}/.common/aliases"
sources+="${ZDOTDIR:-$HOME}/.common/exports"
sources+="${ZDOTDIR:-$HOME}/.common/functions"

# Check for a system specific file
systemFile=`uname -s | tr "[:upper:]" "[:lower:]"`
sources+="${ZDOTDIR:-$HOME}/.system/$systemFile"

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && sources+="${ZDOTDIR:-$HOME}/.localrc"

# try to include all sources
foreach file (`echo $sources`)
  if [[ -a $file ]]; then
    source $file
  fi
end

# Remove duplicates (copied from http://unix.stackexchange.com/a/14896)
#PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
#export PATH
