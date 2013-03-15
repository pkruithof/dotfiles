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

# Solarized Dark colour scheme
typeset -Ag solar solar_bold
solar[base03]=${FG[234]}
solar[base02]=${FG[235]}
solar[base01]=${FG[240]}
solar[base00]=${FG[241]}
solar[base0]=${FG[244]}
solar[base1]=${FG[245]}
solar[base2]=${FG[254]}
solar[base3]=${FG[230]}
solar[yellow]=${FG[136]}
solar[orange]=${FG[166]}
solar[red]=${FG[160]}
solar[magenta]=${FG[125]}
solar[violet]=${FG[061]}
solar[blue]=${FG[033]}
solar[cyan]=${FG[037]}
solar[green]=${FG[064]}

solar_bold[base03]=${FX[bold]}${FG[234]}
solar_bold[base02]=${FX[bold]}${FG[235]}
solar_bold[base01]=${FX[bold]}${FG[240]}
solar_bold[base00]=${FX[bold]}${FG[241]}
solar_bold[base0]=${FX[bold]}${FG[244]}
solar_bold[base1]=${FX[bold]}${FG[245]}
solar_bold[base2]=${FX[bold]}${FG[254]}
solar_bold[base3]=${FX[bold]}${FG[230]}
solar_bold[yellow]=${FX[bold]}${FG[136]}
solar_bold[orange]=${FX[bold]}${FG[166]}
solar_bold[red]=${FX[bold]}${FG[160]}
solar_bold[magenta]=${FX[bold]}${FG[125]}
solar_bold[violet]=${FX[bold]}${FG[061]}
solar_bold[blue]=${FX[bold]}${FG[033]}
solar_bold[cyan]=${FX[bold]}${FG[037]}
solar_bold[green]=${FX[bold]}${FG[064]}

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