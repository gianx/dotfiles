#!/bin/bash


# To install:
#
# brew install coreutils
#
#
#




###############################################
# Prompt                                                                             #
###############################################

_bash_prompt_config() {

  local USER_SYMBOL="\u"
  local HOST_SYMBOL="\h"
  local ESC_OPEN="\["
  local ESC_CLOSE="\]"

  if tput setaf >/dev/null 2>&1 ; then
    _setaf () { tput setaf "$1" ; }
    local RESET="${ESC_OPEN}$( { tput sgr0 || tput me ; } 2>/dev/null )${ESC_CLOSE}"
    local BOLD="$( { tput bold || tput md ; } 2>/dev/null )"
  else
    # Fallback
    _setaf () { echo "\033[0;$(($1+30))m" ; }
    local RESET="\033[m"
    local BOLD=""
    ESC_OPEN=""
    ESC_CLOSE=""
  fi

  # Normal colors
  local BLACK="${ESC_OPEN}$(_setaf 0)${ESC_CLOSE}"
  local RED="${ESC_OPEN}$(_setaf 1)${ESC_CLOSE}"
  local GREEN="${ESC_OPEN}$(_setaf 2)${ESC_CLOSE}"
  local YELLOW="${ESC_OPEN}$(_setaf 3)${ESC_CLOSE}"
  local BLUE="${ESC_OPEN}$(_setaf 4)${ESC_CLOSE}"
  local VIOLET="${ESC_OPEN}$(_setaf 5)${ESC_CLOSE}"
  local CYAN="${ESC_OPEN}$(_setaf 6)${ESC_CLOSE}"
  local WHITE="${ESC_OPEN}$(_setaf 7)${ESC_CLOSE}"

  # Bright colors
  local BRIGHT_GREEN="${ESC_OPEN}$(_setaf 10)${ESC_CLOSE}"
  local BRIGHT_YELLOW="${ESC_OPEN}$(_setaf 11)${ESC_CLOSE}"
  local BRIGHT_BLUE="${ESC_OPEN}$(_setaf 12)${ESC_CLOSE}"
  local BRIGHT_VIOLET="${ESC_OPEN}$(_setaf 13)${ESC_CLOSE}"
  local BRIGHT_CYAN="${ESC_OPEN}$(_setaf 14)${ESC_CLOSE}"
  local BRIGHT_WHITE="${ESC_OPEN}$(_setaf 15)${ESC_CLOSE}"

  # Bold colors
  local BLACK_BOLD="${ESC_OPEN}${BOLD}$(_setaf 0)${ESC_CLOSE}"
  local RED_BOLD="${ESC_OPEN}${BOLD}$(_setaf 1)${ESC_CLOSE}"
  local GREEN_BOLD="${ESC_OPEN}${BOLD}$(_setaf 2)${ESC_CLOSE}"
  local YELLOW_BOLD="${ESC_OPEN}${BOLD}$(_setaf 3)${ESC_CLOSE}"
  local BLUE_BOLD="${ESC_OPEN}${BOLD}$(_setaf 4)${ESC_CLOSE}"
  local VIOLET_BOLD="${ESC_OPEN}${BOLD}$(_setaf 5)${ESC_CLOSE}"
  local CYAN_BOLD="${ESC_OPEN}${BOLD}$(_setaf 6)${ESC_CLOSE}"
  local WHITE_BOLD="${ESC_OPEN}${BOLD}$(_setaf 7)${ESC_CLOSE}"

  # Expose the variables we need in prompt command
  P_USER=${BRIGHT_GREEN}${USER_SYMBOL}
  P_HOST=${CYAN}${HOST_SYMBOL}
  P_WHITE=${WHITE}
  P_GREEN=${BRIGHT_GREEN}
  P_YELLOW=${YELLOW}
  P_RED=${RED}
  P_RESET=${RESET}

}

bash_prompt_command() {

  local EXIT_CODE=$?
  local P_EXIT=""
  local MAXLENGTH=35
  local TRUNC_SYMBOL=".."
  local DIR=${PWD##*/}
  local P_PWD=${PWD}
  # local P_PWD=${PWD/#$HOME/\~}
  
  MAXLENGTH=$(( ( MAXLENGTH < ${#DIR} ) ? ${#DIR} : MAXLENGTH ))

  local OFFSET=$(( ${#P_PWD} - MAXLENGTH ))

  if [ ${OFFSET} -gt "0" ]; then
    P_PWD=${P_PWD:$OFFSET:$MAXLENGTH}
    P_PWD=${TRUNC_SYMBOL}/${P_PWD#*/}
  fi

  # Update terminal title
  if [[ $TERM == xterm* ]]; then
    echo -ne "\033]0;${P_PWD}\007"
  fi

  # Parse Git branch name
  P_GIT=$(parse_git_branch)

  # Exit code
  if [[ $EXIT_CODE != 0 ]]; then
    P_EXIT+="${P_RED}✘ "
  fi

  PS1="${P_EXIT}${P_USER}${P_WHITE}@${P_HOST} ${P_YELLOW}${P_PWD}${P_GREEN}${P_GIT}${P_YELLOW} ❯ ${P_RESET}"
}

parse_git_branch() {
  local OUT=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ "$OUT" != "" ]; then echo " $OUT"; fi
}

_bash_prompt_config
unset _bash_prompt_config

PROMPT_COMMAND=bash_prompt_command



###############################################
# Environment variables                                                     #
###############################################

export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

export LANG='it_IT.UTF-8';
export LC_ALL='it_IT.UTF-8';

export LESS_TERMCAP_md="${yellow}";
export MANPAGER='less -X';

# Current Finder path
  export currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT)

###############################################
# Line input behaviour                                                        #
###############################################

# Make Tab autocomplete regardless of filename case
set completion-ignore-case on

# List all matches in case multiple possible completions are possible
set show-all-if-ambiguous on

# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

# Show all autocomplete results at once
set page-completions off

# If there are more than 200 possible completions for a word, ask to show them all
set completion-query-items 200

# Show extra file information when completing, like `ls -F` does
set visible-stats on

# Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
set input-meta on
set output-meta on
set convert-meta off

###############################################
# Functions                                                                          #
###############################################

# Creates and cd a directory
mcd() {
  mkdir -p "$@" && cd "$_";
}

# Cd to frontmost Finder window
cdf() { # short for `cdfinder`
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}
# Open this directory in Finder
fcd() { # short for `cdfinder`
  open -a Finder ./
}

# Move a file to MacOS trash     
trash () { command mv "$@" ~/.Trash ; } 

# Open a file in MacOS Quicklook preview  
ql () { qlmanage -p "$*" >& /dev/null; } 

# Find... 
ff () { /usr/bin/find . -name "$@" ; }      # ... under current directory ...
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ... files starting with ...
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ... files ending with ...

# Infos
infos (){
  echo -e "Hostname ..... $(hostname) " ;
  echo
  echo -e "Current user ..... $(whoami) " ; 
  echo -e "Current date ..... $(date)";
  echo
  echo -e "Public IP ..... $(ip)";
  echo -e "Local IP ..... $(lip)";
  echo
  echo -e "git repo base dir ... $(git rev-parse --show-toplevel 2> /dev/null)";
  echo -e "git remote origin url ..... $(git config --get remote.origin.url 2> /dev/null)";
  echo -e "git branch ..... $(git branch 2> /dev/null)";
  echo
  echo -e "Frontmost Finder window path ..... $(echo $currFolderPath)"
}

###############################################
# Alias                                                                                 #
###############################################

alias reload="source ~/.bash_profile"



colorflag="-G"
export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'

alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# alias ls="gls"
alias ls="gls -Flh --group-directories-first --time-style=long-iso --color -G"
alias lsa="gls -aFlh --group-directories-first --time-style=long-iso --color -G"
alias ll="lsa"
alias lsd="gls -lF ${colorflag} | grep  '^d'"
alias rr="rm -rf"
alias path='echo -e ${PATH//:/\\n}'

# Alias alternative OsX commands

command -v md5sum > /dev/null || alias md5sum="md5"
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Programs

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# Network addresses

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias lip="ipconfig getifaddr en0"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Volume
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output volume 100'"
