
. "$HOME/.local/share/../bin/env"


# ==================================================
# Environment
# ==================================================
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export HISTFILE="$HOME/.zsh_history"
export EDITOR="nvim"
export VISUAL="nvim"

# ==================================================
# Zinit bootstrap
# ==================================================
ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"

if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# ==================================================
# Completion system (must be early)
# ==================================================
autoload -Uz compinit
compinit

# Completion plugins
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# ==================================================
# Suggestions & highlighting
# ==================================================
zinit light zsh-users/zsh-autosuggestions
#Starship
eval "$(starship init zsh)"
zinit light zsh-users/zsh-syntax-highlighting
# ==================================================
# Keybindings
# ==================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ==================================================
# History
# ==================================================
HISTSIZE=1500
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt inc_append_history

# ==================================================
# Completion styling
# ==================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# fzf-tab previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=auto $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# ==================================================
# Aliases
# ==================================================
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias c='clear'
alias grep='grep --color=auto'

# ==================================================
# Performance & safety
# ==================================================
setopt no_beep
setopt auto_cd
setopt correct
unsetopt nomatch
