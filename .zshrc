# ============================================================================
#  Core environment (fast, minimal, SSH-safe) - ZSH VERSION
# ============================================================================

# Return early if not interactive
[[ $- != *i* ]] && return

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

export PATH="$HOME/.bin:$PATH"

# Rust / Cargo (fast, idempotent)
if [ -d "$HOME/.cargo/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$HOME/.cargo/bin:$PATH" ;;
  esac
fi

# Go
if [ -d "$HOME/.local/go/bin" ]; then
  export PATH="$HOME/.local/go/bin:$PATH"
fi

# Go workspace (optional, recommended)
export GOPATH="$HOME/.local/gopath"
export PATH="$GOPATH/bin:$PATH"

# Neovim as default editor
export EDITOR=nvim
export VISUAL=nvim

# Bat config
export BAT_THEME="Catppuccin Mocha"
export MANPAGER="bat -plman"

# ============================================================================
#  History (large, persistent, useful) - ZSH
# ============================================================================

export HISTSIZE=100000
export SAVEHIST=200000
export HISTFILE=~/.zsh_history

# Zsh-specific history options
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from history items
setopt INC_APPEND_HISTORY    # Immediately append to history file
setopt SHARE_HISTORY         # Share history between sessions
setopt HIST_IGNORE_SPACE     # Ignore commands starting with space
setopt EXTENDED_HISTORY      # Save timestamp and duration

# ============================================================================
#  Zsh Options (quality of life improvements)
# ============================================================================

# Navigation
setopt AUTO_CD              # Type directory name to cd
setopt AUTO_PUSHD           # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt PUSHD_SILENT         # Don't print directory stack

# Completion
setopt COMPLETE_IN_WORD     # Complete from both ends of a word
setopt ALWAYS_TO_END        # Move cursor to end on complete
setopt AUTO_MENU            # Show completion menu on tab
setopt AUTO_LIST            # Automatically list choices on ambiguous completion
setopt MENU_COMPLETE        # Automatically select first option on ambiguous completion

# Correction
setopt CORRECT              # Suggest corrections for commands
setopt CORRECT_ALL          # Suggest corrections for all arguments

# Misc
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell

# ============================================================================
#  Prompt - Starship
# ============================================================================

# Initialize Starship prompt (Catppuccin Mocha + Powerline preset)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ============================================================================
#  Completion System
# ============================================================================

# Initialize the completion system
autoload -Uz compinit

# Only regenerate compdump once a day for performance
# This is a zsh optimization for faster startup
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Completion styling
zstyle ':completion:*' menu select                        # Visual menu for completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion

# ============================================================================
#  Aliases
# ============================================================================

alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias grep='grep --color=auto'
alias cat='bat --paging=never --style=plain'
alias df='duf 2>/dev/null || df -h'
alias du='du -h'
alias mkdir='mkdir -pv'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias cls='clear && ls'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# System monitoring
if command -v btop >/dev/null; then
  alias top='btop'
  alias htop='btop'
fi

# GitHub CLI shortcuts
if command -v gh >/dev/null; then
  alias ghpr='gh pr view --web'
  alias ghprs='gh pr status'
  alias ghcl='gh repo clone'
fi

# ============================================================================
#  Navigation helpers
# ============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if command -v fzf >/dev/null; then
  alias ff='fzf'
  alias fh='history 1 | fzf'
fi

# ============================================================================
#  Dev / ML environment
# ============================================================================

export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
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
#  Zsh key bindings (better than bash defaults)
# ============================================================================

# Use emacs keybindings (can switch to vi mode with: bindkey -v)
bindkey -e

# Better history search with arrow keys
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow

# Ctrl+arrow word navigation
bindkey "^[[1;5C" forward-word     # Ctrl+Right
bindkey "^[[1;5D" backward-word    # Ctrl+Left

# Home/End keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Delete key
bindkey "^[[3~" delete-char

export TMOUT=0

# ============================================================================
#  Tool integrations (lazy-loaded)
# ============================================================================

# FZF keybindings and completion
if [ -f "$HOME/.local/fzf/shell/key-bindings.zsh" ]; then
  source "$HOME/.local/fzf/shell/key-bindings.zsh"
fi

if [ -f "$HOME/.local/fzf/shell/completion.zsh" ]; then
  source "$HOME/.local/fzf/shell/completion.zsh"
fi

# Zoxide (smart cd)
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
  alias zd='z'  # Quick alias for zoxide
fi

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
