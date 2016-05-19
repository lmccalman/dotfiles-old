function my_git_prompt() {
tester=$(git rev-parse --git-dir 2> /dev/null) || return

INDEX=$(git status --porcelain 2> /dev/null)
STATUS=""

# is branch ahead?
if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
fi

# is anything staged?
if $(echo "$INDEX" | grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
fi

# is anything unstaged?
if $(echo "$INDEX" | grep -E -e '^[ MARC][MD] ' &> /dev/null); then
  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
fi

# is anything untracked?
if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
fi

# is anything unmerged?
if $(echo "$INDEX" | grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
fi

if [[ -n $STATUS ]]; then
  STATUS=" $STATUS"
fi

echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local blue_cp="%{$fg[blue]%}]%{$reset_color%}"

function my_current_branch() {
echo $(current_branch || echo "no branch")
}

function ssh_connection() {
if [[ -n $SSH_CONNECTION ]]; then
  echo "-${blue_op}ssh${blue_cp}"
fi
}

function holyday() {
HOLYDAY=$(ddate +%H)
if [[ -n ${HOLYDAY} ]]; then
  echo "-${blue_op}${HOLYDAY}${blue_cp}"
fi
}

function virtualenv_print() {
    if [[ -n ${VIRTUAL_ENV} ]]; then
      VSTRING=venv:$(basename ${VIRTUAL_ENV})
      echo "-${blue_op}${VSTRING}${blue_cp}"
        fi
}

function cabal_sandbox_info() {
    cabal_files=(*.cabal(N))
    if [ $#cabal_files -gt 0 ]; then
        if [ -f cabal.sandbox.config ]; then
          echo "-${blue_op}%{$fg[green]%}sandboxed%{$reset_color%}${blue_cp}"
        else
          echo "-${blue_op}%{$fg[red]%}not sandboxed%{$reset_color%}${blue_cp}"
        fi
    fi
}


PROMPT=$'\n┌${user_host}$(ssh_connection)$(my_git_prompt)$(virtualenv_print)$(cabal_sandbox_info)$(holyday)
└${blue_op}${smiley}${blue_cp}-> '

RPROMPT="%F{${1:-green}}%~%f"

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="-${blue_op}%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✕"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}${blue_cp}"

local path_p="${blue_op}%~${blue_cp}"
local user_host="${blue_op}%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[cyan]%}%m${blue_cp}"
local ret_status="${blue_op}%?${blue_cp}"
local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"

