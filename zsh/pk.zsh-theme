# Initialize colors.
autoload -U colors
colors

# Allow for functions in the prompt.
setopt PROMPT_SUBST

function get_load() {
  uptime | awk '{print $(NF-2)}' | sed 's/,$//g'
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function update_current_git_vars() {
  local gitstatus="$HOME/.zsh/gitstatus.py"
  _GIT_STATUS=`python ${gitstatus}`
  __CURRENT_GIT_STATUS=("${(@f)_GIT_STATUS}")
  GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
  GIT_REMOTE=$__CURRENT_GIT_STATUS[2]
  GIT_STAGED=$__CURRENT_GIT_STATUS[3]
  GIT_CONFLICTS=$__CURRENT_GIT_STATUS[4]
  GIT_CHANGED=$__CURRENT_GIT_STATUS[5]
  GIT_UNTRACKED=$__CURRENT_GIT_STATUS[6]
  GIT_CLEAN=$__CURRENT_GIT_STATUS[7]
}


git_super_status() {
    update_current_git_vars
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
      STATUS="($GIT_BRANCH"
      STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
      if [ -n "$GIT_REMOTE" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_REMOTE$GIT_REMOTE%{${reset_color}%}"
      fi
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
      if [ "$GIT_STAGED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
      fi
      if [ "$GIT_CONFLICTS" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
      fi
      if [ "$GIT_CHANGED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
      fi
      if [ "$GIT_UNTRACKED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
      fi
      if [ "$GIT_CLEAN" -eq "1" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
      fi

      STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
      echo "$STATUS"
    fi
}

precmd () {
  # Current directory in tab/window title
  print -Pn "\e]2;%~\a"
}

# Build the main prompt
PROMPT='
'                                                # start with empty line
PROMPT+='%{$solar[orange]%}%n$(virtualenv_info)' # user
PROMPT+='%{$solar[base3]%}@'                     # @
PROMPT+='%{$solar[yellow]%}%m'                   # host
PROMPT+='%{$solar[base3]%}:'                     # path char
PROMPT+='%{$solar[green]%}${PWD/#$HOME/~}'       # pwd
PROMPT+='%{$reset_color%} '                      #
PROMPT+='$(git_super_status)'                    # git branch status
PROMPT+='
%{$reset_color%}% %# '                           # newline + prompt char

SOLAR_BLUE=$(tput setaf 33)

# # Displays different symbols (simultaneously) depending on the current status of your git repo.
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$FG[037]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$FG[125]%}●"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$FG[160]%}✖"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$FG[166]%}✚"
ZSH_THEME_GIT_PROMPT_REMOTE=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FX[bold]$FG[064]%}✔"

ZSH_THEME_GIT_PROMPT_DIRTY=""
#ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="!"
ZSH_THEME_GIT_PROMPT_DELETED="✖"
ZSH_THEME_GIT_PROMPT_RENAMED="➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="═"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="?"

RPROMPT='%{$solar[base02]%}load:$(get_load)'
RPROMPT+=' · %{$solar_bold[cyan]%}%*%{$reset_color%}'