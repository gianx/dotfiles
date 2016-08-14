# ~/.bash_profile

[[ -s ~/.bashrc ]] && source ~/.bashrc

# For bash completition: http://davidalger.com/development/bash-completion-on-os-x-with-brew/
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

###################################################################################
# FUNCTIONS
###################################################################################

function myfunct() {
  # Makes a dir and jumps inside
  mcd () { mkdir -p "$1" && cd "$1"; } 

  # Move a file to MacOS trash     
  trash () { command mv "$@" ~/.Trash ; } 

  # Open a file in MacOS Quicklook preview  
  ql () { qlmanage -p "$*" >& /dev/null; }  

  # Find... 
  ff () { /usr/bin/find . -name "$@" ; }      # ... under current directory ...
  ffs () { /usr/bin/find . -name "$@"'*' ; }  # ... files starting with ...
  ffe () { /usr/bin/find . -name '*'"$@" ; }  # ... files ending with ...

  # Open frontmost window of MacOS Finder
  fcd () {
          echo "cd to \"$currFolderPath\""
          cd "$currFolderPath"
  }
  # Get infos
  infos() {

      echo
      echo -e "Hostname ..... $(hostname) " ;
      echo -e "Current user ..... $(whoami) " ; 
      echo -e "Current date ..... $(date)";
      echo  
      echo -e "Public facing IP Address ..... $(curl -s ip.appspot.com) " ; 
      echo -e "en0 address ..... $(ipconfig getifaddr en0)";
      echo
      echo -e "git repo base dir ... $(git rev-parse --show-toplevel 2> /dev/null)";
      echo -e "git remote origin url ..... $(git config --get remote.origin.url 2> /dev/null)";
      echo -e "git branch ..... $(git branch 2> /dev/null)";
      echo
      echo -e "Frontmost Finder window path ..... $(echo $currFolderPath)"
      echo 
      echo -e "Useful commands:
      - mcd: makes a dir and jumps inside;
      - trash: move a file to MacOS trash;
      - ql: open with Quicklook;
      - ff: find in current directory;
      - ffe: find in current directory files starting with a string;
      - ffe: find in current directory files ending with a string;
      - fcd: open frontmost window of MacOS Finder;
      - f: opens current directory in MacOS Finder;
      - cleanupDS: cleans .DS_Store;
      - cleanupLS: fix \"Open with\" menu;";
      echo
  }
}

###################################################################################
# VARIABLES
###################################################################################

function myvar {
  # Color terminal
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
  # Default editor
  export EDITOR=//Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
  # Set default blocksize for ls, df, du
  export BLOCKSIZE=1k 
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
  # Cleanup .DS_STORE files
  alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
  alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
}

###################################################################################
# ALIASES
###################################################################################

function myalias {
  alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
  alias ls='ls -GFh'
  alias ll='ls -l'

  alias cd..='cd ../'
  alias ..='cd ../'
  alias ...='cd ../../'

  alias f='open -a Finder ./'

  alias fixtty='stty sane' # Fix terminal settings when screwed up
}

###################################################################################
# PROMPT
###################################################################################

function myprompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  # export PS1="$BLUE[\#] $RED\u$PURPLE$RESETCOLOR@\H$GREEN:\w $RESETCOLOR$GREENBOLD\$(git config --get remote.origin.url 2> /dev/null)\$(git branch 2> /dev/null) $BLUE →  $RESETCOLOR"
  export PS1="$BLUE[\#] $RED\u$PURPLE$RESETCOLOR@\H$GREEN:\w #  $RESETCOLOR"
  export PS2=" | → $RESETCOLOR"

}

###################################################################################
# MAIN
###################################################################################

myfunct
myvar
myalias
myprompt


