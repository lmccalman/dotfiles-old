# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="lb"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python taskwarrior)

source $ZSH/oh-my-zsh.sh
#Customize!
setopt extended_glob

#Aliases
alias cp="rsync -az --progress"
alias shutdown="sudo shutdown -P -h now"
export GREP_COLOR="1;33"                        #light yellow?
alias grep="grep --color=auto"
export LESS="-R"   		                          #for colour
alias df="df -h"
alias du="du -c -h"
alias mkdir="mkdir -p"
alias nano="nano -w"
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




zle-keymap-select () {
  case $KEYMAP in
    vicmd) print -rn -- $terminfo[cvvis];; # block cursor
  viins) print -rn -- $terminfo[cnorm];; # less visible cursor
esac
}

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

#Set the title of the window
precmd()
{
  echo -ne "\033]0;${PWD/$HOME/~} (${USER}@${HOST})\007"
}

export PYTHONPATH=$PYTHONPATH:$HOME/code/geotherml/lib
export EDITOR=/usr/bin/vim
export TERM=xterm-256color
#for ruby gems
export PATH=$PATH:/home/lb/.gem/ruby/2.0.0/bin
#
#Japanese input
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# CUDA
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

fortune -e
#echo "\n"
#task list
