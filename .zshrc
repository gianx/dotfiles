COMPLETION_WAITING_DOTS="true"

plugins=(git colorize)


export LANG=en_US.UTF-8

# --- VIMODE

bindkey -v
KEYTIMEOUT=5

# Change cursor shape for different vi modes.


# --- HISTORY

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HIST_FORMAT="'%Y-%m-%d %T:'$(echo -e '\t')"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt autopushd

# TAB Completion

autoload -Uz compinit && compinit

###########################################################################
#
# GIT
#
###########################################################################

autoload -Uz vcs_info

###########################################################################
#
# ALIAS
#
###########################################################################

alias zshrc='vi ~/.zshrc'
alias sourcez="source ~/.zshrc"

alias ls='ls -lh --color=tty'
alias ll='ls -a'
alias df='df -H'
alias du='du -ach | sort -h'
alias mkdir='mkdir -pv'
alias rr='rm -fr'

alias h='history'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias mount='mount | column -t'
alias now='date +"%d.%m.%y %H:%M:%S"'
alias update='yum update'
alias updatey='yum -y update'

alias meminfo='free -m -l -t -h'
alias cpuinfo='lscpu'
alias mem='ps auxf | sort -nr -k 4 | head -10'
alias cpu='ps auxf | sort -nr -k 3 | head -10'
alias ps='ps auxf'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias tls="tmux ls"
alias tnew="tmux new -s"
alias trename="tmux rename-session -t"
alias tattach="tmux attach -t"

alias gp="git diff --stat --cached origin/master"


alias history='fc -t "%Y-%m-%d %T:" -il '

alias cd..="cd .."
alias cd.="cd ."
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Define default programs

alias -s {yml,yaml,json}=vim

###########################################################################
#
# PROMPT
#
###########################################################################
autoload -U colors && colors

PUBLIC_IP="`dig +short myip.opendns.com @resolver1.opendns.com`"

PROMPT="%F{magenta}%n%f"  # User name
PROMPT+="@"
PROMPT+="%F{blue}%m " # Host name
PROMPT+="%F{yellow}%1~ %f" # Working directory
PROMPT+=" \$ "

# Check last exit code

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    # Get local ip
    localip
    # Calculate command duration
    now=$(($(date +%s%0N)/1000000))
    elapsed=$((($now-$timer)/1000))
    # Calculate hour
    nowdate=$(date +"%H:%M:%S")
    # GIT: Changes not staged for commit
    GIT_branch=$(git rev-parse --abbrev-ref HEAD)
    GIT_remote_origin=$(git config --get remote.origin.url)
    GIT_not_staged=$(git status -s -uno | wc -l)
    GIT_staged=$(git diff --cached --numstat | wc -l)
    # Generate right prompt
    export RPROMPT="%(?,%F{green}OK,%F{red}ERROR:%?) %F{blue}[${elapsed}s] %F{yellow}$LOCALIP"
    #export RPROMPT="%(?,%F{green}OK,%F{red}ERROR:%?) %F{blue}[${elapsed}s] %F{yellow}$nowdate $GIT_not_staged $GIT_staged"
    unset timer
  fi
}

###########################################################################
#
# FUNCTIONS
#
###########################################################################

mcd () {
    mkdir -p $1
    cd $1
}

publicip () {
    export PUBLICIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
    echo $PUBLICIP
}

localip () {
    export LOCALIP=$(ifconfig eth0| grep "inet[ ]" | awk '{print $2}')
    #echo $LOCALIP
}

# Infos
infos (){
  echo -e "Hostname ..... $(hostname) " ;
  echo
  echo -e "Current user ..... $(whoami) " ; 
  echo -e "Current date ..... $(date)";
  echo
  echo -e "Public IP ..... $(publicip)";
  echo -e "Local IP ..... $(localip)";
  echo
  echo -e "git repo base dir ... $(git rev-parse --show-toplevel 2> /dev/null)";
  echo -e "git remote origin url ..... $(git config --get remote.origin.url 2> /dev/null)";
  echo -e "git branch ..... $(git branch 2> /dev/null)";
  echo
  echo -e "Frontmost Finder window path ..... $(echo $currFolderPath)"
}

case "$OSTYPE" in
    darwin*)
        # Insert here Mac specific functions
    ;;
    linux*)
        # Insert here linux specific functions
    ;;
esac

###########################################################################
#
# PYENV (generated by the installation procedure)
#
###########################################################################

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"
# Configure a Mac
