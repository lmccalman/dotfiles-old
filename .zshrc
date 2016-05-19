# Add my custom completion directory
fpath=(~/.zsh/completion $fpath)

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="lb"
COMPLETION_WAITING_DOTS="true"

export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUAL_ENV_DISABLE_PROMPT=true
source /usr/bin/virtualenvwrapper.sh

plugins=(git python zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh

#Customize!
setopt extended_glob

#Aliases
alias shutdown="sudo shutdown -P -h now"
alias grep="grep --color=auto"
export LESS="-R"   		                          #for colour
alias df="df -h"
alias du="du -c -h"
alias ping="ping -c 3"
alias ..="cd .."
alias feh="feh -."
#new commands
alias aoeu='setxkbmap us'
alias asdf='setxkbmap dvorak'
alias openports="netstat --all --numeric --programs --inet --inet6"
alias ison="ps -A | grep $1"
alias listfonts="fc-list | sed 's,:.*,,' | sort -u"
alias fontinfo="otfinfo -f"
# ls
alias ls="ls -hF --color=auto"
alias lr="ls -R"                    # recursive ls
alias ll="ls -l"
alias la="ll -A"
alias lx="ll -BX"                   # sort by extension
alias lz="ll -rS"                   # sort by size
alias lt="ll -rt"                   # sort by date
alias lm="la | more"
# pacman/pacaur
alias pacall="LC_ALL=C pacman -Qi | sed -n '/^Name[^:]*: \(.*\)/{s//\1 /;x};/^Installed[^:]*: \(.*\)/{s//\1/;H;x;s/\n//;p}' | sort -nk2 | column -t"
alias pacupg='pacaur -Syu' # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='pacaur -S' # Install specific package(s) from the repositories
alias pacins='sudo pacman -U' # Install specific package not from the repositories but from a file
alias pacre='pacaur -R' # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='pacaur -Rns' # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinf='pacaur -Si' # Display information about a given package in the repositories
alias pacs='pacaur -Ss' # Search for package(s) in the repositories
alias pacloc='pacaur -Qi' # Display information about a given package in the local database
alias pacfiles='pacaur -Ql' # list the files from a certain pacagke
alias paclocs='pacaur -Qs' # Search for package(s) in the local database
alias pacupd='sudo pacman -Sy' # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps' # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy' # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

alias presenting='xrandr --auto'
alias onthemove='xrandr --output VIRTUAL1 --off --output eDP1 --mode 3200x1800 --pos 0x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output VGA1 --off'
alias atdesk='xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output VGA1 --off'

alias nvsteam=LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1' primusrun steam 

# coloured output for less
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


# GREP
unset GREP_OPTIONS

# OPAM configuration
. /home/lb/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR=/usr/bin/nvim
export ICAROOT="/home/lb/progs/citrix"
export PATH=$PATH:/home/lb/.local/bin
export TERM=xterm
export PYTHONPATH=PYTHONPATH:/home/lb/code/statbadger
