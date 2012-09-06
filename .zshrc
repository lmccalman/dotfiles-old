# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
autoload -Uz zsh-newuser-install;

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Errors: %e'
zstyle :compinstall filename '/home/fatbot/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

fpath=(/usr/share/zsh/functions $fpath)

# For pre-done prompts
autoload -U promptinit
promptinit
#prompt adam1

autoload -U colors
colors

setopt completealiases


#aliases
alias aoeu='setxkbmap us'
alias asdf='setxkbmap dvorak'
alias cp="rsync -az --progress"
alias torrent=su torrentuser -c ktorrent
alias shutdown="sudo shutdown -P -h now"
export GREP_COLOR="1;33"           # light yellow?
alias grep="grep --color=auto"
#alias pacman="pacman-color"
#alias more="less"
export LESS="-R"   		   #for colour
alias df="df -h"
alias du="du -c -h"
alias mkdir="mkdir -p"
alias nano="nano -w"
alias ping="ping -c 5"
alias ..="cd .."
alias feh="feh -."

#new commands
alias openports="netstat --all --numeric --programs --inet --inet6"
alias ison="ps -Af | grep $1"
alias fnts="fc-list | sed 's,:.*,,' | sort -u"

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
alias pacupg='pacaur -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='pacaur -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
alias pacre='pacaur -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='pacaur -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinf='pacaur -Si'              # Display information about a given package in the repositories
alias pacs='pacaur -Ss'             # Search for package(s) in the repositories
alias pacloc='pacaur -Qi'              # Display information about a given package in the local database
alias pacfiles='pacaur -Ql'            # list the files from a certain pacagke
alias paclocs='pacaur -Qs'             # Search for package(s) in the local database
alias pacupd='sudo pacman -Sy'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist


zle-keymap-select () {
  case $KEYMAP in
    vicmd) print -rn -- $terminfo[cvvis];; # block cursor
    viins) print -rn -- $terminfo[cnorm];; # less visible cursor
  esac
}





PROMPT="%F{${1:-magenta}}%n%f@%F{${1:-cyan}}%m%f% ${VIMODE}# "
RPROMPT="%F{${1:-green}}%~%f"


#pretty colours from .Xdefaults when in virtual console

if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

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



export PYTHONPATH=$PYTHONPATH:$HOME/geotherml/lib:$HOME/phd/repo/reverend
export EDITOR=/usr/bin/vim
export TERM=xterm-256color
#for ruby gems
export PATH=$PATH:/home/lb/.gem/ruby/1.9.1/bin


#Japanese input
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

#python virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
source virtualenvwrapper.sh

fortune -a -e
echo "\n"
task list

