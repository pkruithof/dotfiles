function get_RAM {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    ruby /Applications/Utilities/free-memory.rb
  else
    free -m | awk '{if (NR==3) print $4}' | xargs -i echo 'scale=1;{}/1000' | bc
  fi
}

function get_nr_CPUs() {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    sysctl -n hw.ncpu
  else
    grep -c "^processor" /proc/cpuinfo
  fi
}

function get_load() {
  uptime | awk '{print $8}' | sed 's/,$//g'
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function git_prompt_status {
}

precmd () {
  # Current directory in tab/window title
  print -Pn "\e]2;%~\a"
}


# Build the main prompt
PROMPT='
'
PROMPT+='%{$solar[orange]%}%n$(virtualenv_info)'                # user
PROMPT+='%{$solar[base3]%}@'                                   # @
PROMPT+='%{$solar[yellow]%}%m'                   # host
PROMPT+='%{$solar[base3]%}:' # path char
PROMPT+='%{$solar[green]%}${PWD/#$HOME/~}' # pwd
PROMPT+='%{$reset_color%}$(git_prompt_info)'             # git branch info
PROMPT+='$(git_prompt_status)'             # git branch status
PROMPT+='$(git_remote_status)'                                # git remote status
PROMPT+='
%{$reset_color%}% %# ' # newline + prompt char

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$solar[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

# # Displays different symbols (simultaneously) depending on the current status of your git repo.
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="!"
ZSH_THEME_GIT_PROMPT_DELETED="✖"
ZSH_THEME_GIT_PROMPT_RENAMED="➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"

RPROMPT='%{$solar[base02]%}load:$(get_load)'
RPROMPT+=' · %{$solar_bold[cyan]%}%*%{$reset_color%}'