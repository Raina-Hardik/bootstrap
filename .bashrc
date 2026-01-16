# ============================================================================
#  Core environment (fast, minimal, SSH-safe)
# ============================================================================

[[ $- != *i* ]] && return

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

export PATH="$HOME/.bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

# ============================================================================
#  History (large, persistent, useful)
# ============================================================================

export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:ll:cd:pwd:exit:clear"
shopt -s histappend
PROMPT_COMMAND='history -a'

# ============================================================================
#  Git branch (FAST, cached)
# ============================================================================

__git_branch() {
  local head
  head=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  echo " (${head})"
}

# ============================================================================
#  Prompt (fast, informative, SSH-safe)
# ============================================================================

__c_reset="\[\e[0m\]"
__c_user="\[\e[1;32m\]"
__c_host="\[\e[1;34m\]"
__c_path="\[\e[1;36m\]"
__c_git="\[\e[1;33m\]"

PS1="${__c_user}\u${__c_reset}@${__c_host}\h${__c_reset}:${__c_path}\w${__c_git}\$(__git_branch)${__c_reset} \$ "

# ============================================================================
#  Aliases
# ============================================================================

alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias grep='grep --color=auto'
alias cat='bat 2>/dev/null || command cat'
alias df='duf 2>/dev/null || df -h'
alias du='du -h'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias cls='clear && ls'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ============================================================================
#  Navigation helpers
# ============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if command -v fzf >/dev/null; then
  alias ff='fzf'
  alias fh='history | fzf'
fi

# ============================================================================
#  Dev / ML environment
# ============================================================================

export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

if command -v direnv >/dev/null; then
  eval "$(direnv hook bash)"
fi

# ============================================================================
#  HPC / Module system (INTENTIONALLY EMPTY)
#  Add things like:
#     module load cuda/12.2
#     module load gcc/11
# ============================================================================

if command -v module >/dev/null; then
  :
fi

# ============================================================================
#  SSH quality-of-life
# ============================================================================

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

export TMOUT=0

# ============================================================================
#  Tool integrations (lazy-loaded)
# ============================================================================

[ -f "$HOME/.local/fzf/shell/key-bindings.bash" ] \
  && source "$HOME/.local/fzf/shell/key-bindings.bash"

# ============================================================================
#  Misc helpers
# ============================================================================

extract () {
  [ -f "$1" ] || { echo "Not a file"; return 1; }
  case "$1" in
    *.tar.bz2) tar xjf "$1"    ;;
    *.tar.gz)  tar xzf "$1"    ;;
    *.tar.xz)  tar xJf "$1"    ;;
    *.bz2)     bunzip2 "$1"    ;;
    *.gz)      gunzip "$1"     ;;
    *.tar)     tar xf "$1"     ;;
    *.tbz2)    tar xjf "$1"    ;;
    *.tgz)     tar xzf "$1"    ;;
    *.zip)     unzip "$1"      ;;
    *.7z)      7z x "$1"       ;;
    *.xz)      unxz "$1"       ;;
    *) echo "Don't know how to extract '$1'" ;;
  esac
}

# ============================================================================
#  Session info (interactive only)
# ============================================================================

echo "Ready | $(hostname) | $(date '+%Y-%m-%d %H:%M')"
