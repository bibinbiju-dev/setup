---
id: python-nvim-setup
aliases: []
tags: []
---

# Python Setup for Neovim (LazyVim / Pyright)

[[VLC]]
[[plymouth]]
[[ssh_git]]
[[Render-markdown]]

This document explains clean, reproducible, and project-safe ways to configure Python for Neovim. It focuses on virtual environments (`.venv`), mise, and Pyright integration.

---

## Core Concept

- `mise` → selects Python version
- `.venv` → stores project dependencies (numpy, etc.)
- Pyright → reads `.venv`

Even if you use `mise`, you must install packages inside `.venv`, not globally.

---

## Recommended Setup (TL;DR)

- Use `mise` per project
- Create a `.venv` inside the project
- Install packages inside `.venv` using `pip`
- Let Pyright auto-detect the environment

Avoid:

- Global package installs
- Hardcoding `pythonPath`

---

## Setup Workflow

### 1. Create a project directory

bash
mkdir ~/project_name
cd ~/project_name

- 1. Set Python version (using mise)
     mise use python@3.11
- 1. Create virtual environment
     python -m venv .venv
- 1. Activate virtual environment (for terminal usage)
     source .venv/bin/activate

This is required for terminal usage but not required for Pyright in Neovim.

1. Install packages
   pip install --upgrade pip
   pip install pynvim
   pip install numpy

Always run these inside .venv.

1. (Optional) Configure Pyright

Create pyrightconfig.json only if needed:

{
"venvPath": ".",
"venv": ".venv"
}

Usually not required because Pyright auto-detects .venv.

Daily Workflow

For terminal usage:

source .venv/bin/activate

This is needed once per new terminal session. Not required inside Neovim.

Using mise

Install Python versions:

mise install python@3.9
mise install python@3.11

Set Python version per project:

mise use python@3.9

This creates a mise.toml file in the project directory.

Important:

mise does not replace .venv
Do not install project dependencies globally
Environment Isolation
Same Python, Different Packages
projectA/
Python 3.11
.venv → numpy 1.24

projectB/
Python 3.11
.venv → numpy 2.0

Same Python version, different dependencies, no conflicts.

Different Python Versions
projectA/
Python 3.9 (via mise)
.venv → numpy 1.21

projectB/
Python 3.14 (via mise)
.venv → numpy 2.4

Different Python versions and different dependencies, fully isolated.

Common Mistake

Installing packages globally:

pip install numpy

This installs into global Python (e.g., mise installation path), not your project.

Optional Automation (direnv)

To avoid manual activation:

printf "use mise\nlayout python\n" > .envrc
direnv allow

Now, whenever you enter the project directory:

cd project_name

The correct Python version is selected and .venv is activated automatically.

Debugging in Neovim
:LspInfo
:checkhealth provider

To verify Python path:

import sys
print(sys.executable)
Rule of Thumb

One project → one Python version → one .venv → isolated dependencies
