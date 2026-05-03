# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
alias p='python'
alias q='clear'
alias ani='ani-cli'
alias tt='tmux'
alias vim='nvim'
alias y='yazi'
alias lg='lazygit'
#alias vf='nvim $(fzf -m --preview="bat --color=always {}")'
# alias mvfz='mv "$(fd --type f | fzf)" "$(zoxide query -l | fzf)"'
# alias cpfz='cp "$(fd --type f | fzf)" "$(zoxide query -l | fzf)"'
alias vf='nvim $(fd --type f -H -I --exclude .git | fzf -m --preview="bat --color=always {}")'
alias mvfz='mv -iv "$(fd --type f -H -I --exclude .git | fzf)" "$(zoxide query -l | fzf)"'
alias cpfz='cp -iv "$(fd --type f -H -I --exclude .git | fzf)" "$(zoxide query -l | fzf)"'
#alias sv="source .venv/bin/activate"
alias venv='[ -f .venv/bin/activate ] && source .venv/bin/activate || echo "No .venv found"'
#alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :300 {}'"
#alias ff="fzf --preview 'bat --style=numbers --color=always --line-range=:300 {} 2>/dev/null || cat {}'"
#alias ff="fzf --preview 'bat --style=numbers --color=always --theme=Dracula --line-range=:300 {} 2>/dev/null || cat {}'"
alias ffb='ff | xargs -r bat --style=numbers --color=always  --line-range=:300'
# jf() {
#   local dir
#   dir=$(
#     (
#       zoxide query -l
#       fd --type d . ~ 2>/dev/null
#     ) | awk '!seen[$0]++' | fzf --height 40% --reverse --border
#   ) || return
#
#   cd "$dir" || return
# }
# jf() {
#   local file
#   file=$(ff) || return
#   [ -n "$file" ] && cd "$(dirname "$file")" || return
# }
jf() {
  local dir
  dir=$(fd --type d --hidden --exclude .git . ~ 2>/dev/null | fzf)
  [ -n "$dir" ] && cd "$dir" || return
}
# File system
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
else
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi
alias eff='$EDITOR "$(ff)"'
sff() {
  if [ $# -eq 0 ]; then
    echo "Usage: sff <destination> (e.g. sff host:/tmp/)"
    return 1
  fi
  local file
  file=$(find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2- | ff) && [ -n "$file" ] && scp "$file" "$1"
}

if command -v zoxide &>/dev/null; then
  alias cd="zd"
  zd() {
    if (($# == 0)); then
      builtin cd ~ || return
    elif [[ -d $1 ]]; then
      builtin cd "$1" || return
    else
      if ! z "$@"; then
        echo "Error: Directory not found"
        return 1
      fi

      printf "\U000F17A9 "
      pwd
    fi
  }
fi

open() (
  xdg-open "$@" >/dev/null 2>&1 &
)

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias c='opencode'
alias cx='printf "\033[2J\033[3J\033[H" && claude --permission-mode bypassPermissions'
alias d='docker'
alias r='rails'
alias t='tmux attach || tmux new -s Work'
alias i='tdl c cx'
n() { if [ "$#" -eq 0 ]; then command nvim .; else command nvim "$@"; fi; }

# Git
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'
