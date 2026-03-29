# Dotfiles

My Omarchy Linux configuration files managed with GNU Stow.

## What's Included

- **hypr/** - Hyprland window manager config
- **waybar/** - Status bar config
- **mako/** - Notifications
- **alacritty/** - Terminal emulator
- **kitty/** - Terminal emulator
- **ghostty/** - Terminal emulator
- **fish/** - Shell config
- **nvim/** - Neovim editor
- **starship.toml** - Shell prompt
- **tmux.conf** - Terminal multiplexer
- **XCompose** - Compose key mappings
- **btop/** - System monitor
- **fastfetch/** - System info tool
- **lazygit/** - TUI for git
- **git/** - Git config
- **omarchy/themes/** - Custom themes
- **omarchy/hooks/** - Automation hooks
- **omarchy/extensions/** - Extensions

## Setup

1. Install GNU Stow:

   ```bash
   sudo pacman -S stow
   ```

2. Clone this repo:

   ```bash
   git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

3. Install configs:

   ```bash
   make install
   ```

## Usage

To update a single config (e.g., after editing):

```bash
stow -v -t ~ hypr
```

To restow all:

```bash
make install
```
