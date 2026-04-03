# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
# alias cx="claude --permission-mode=plan --allow-dangerously-skip-permissions"
set -o vi
bind 'set show-mode-in-prompt on'
bind 'set vi-cmd-mode-string "\1\e[1;31m\2[N]\1\e[0m\2 "'
bind 'set vi-ins-mode-string "\1\e[1;32m\2[I]\1\e[0m\2 "'
alias c='clear'
alias ani='ani-cli'
alias tt='tmux'
alias n='nvim'
alias y='yazi'
#alias vf='nvim $(fzf -m --preview="bat --color=always {}")'
# alias mvfz='mv "$(fd --type f | fzf)" "$(zoxide query -l | fzf)"'
# alias cpfz='cp "$(fd --type f | fzf)" "$(zoxide query -l | fzf)"'
alias vf='nvim $(fd --type f -H -I --exclude .git | fzf -m --preview="bat --color=always {}")'
alias mvfz='mv -iv "$(fd --type f -H -I --exclude .git | fzf)" "$(zoxide query -l | fzf)"'
alias cpfz='cp -iv "$(fd --type f -H -I --exclude .git | fzf)" "$(zoxide query -l | fzf)"'
. "$HOME/.local/share/../bin/env"

jf() {
  local dir
  dir=$(
    (
      zoxide query -l
      fd --type d . ~ 2>/dev/null
    ) | awk '!seen[$0]++' | fzf --height 40% --reverse --border
  ) || return

  cd "$dir" || return
}
