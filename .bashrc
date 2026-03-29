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
alias c='clear'
alias ani='ani-cli'
alias tt='tmux'
alias n='nvim'
alias y='yazi'
alias vf='nvim $(fzf -m --preview="bat --color=always {}")'
# alias mvfz='mv "$(fd --type f | fzf)" "$(zoxide query -l | fzf)"'
# alias cpfz='cp "$(fd --type f | fzf)" "$(zoxide query -l | fzf)"'
alias mvfz='mv -iv "$(fd --type f -H -I --exclude .git | fzf)" "$(zoxide query -l | fzf)"'
alias cpfz='cp -iv "$(fd --type f -H -I --exclude .git | fzf)" "$(zoxide query -l | fzf)"'
. "$HOME/.local/share/../bin/env"
