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

This document explains **clean, reproducible, and project-safe ways** to configure Python for Neovim.
It focuses on **virtual environments**, **mise**, and **Pyright** integration.

---

<!-- NOTE: --> if i use first methos the packages will only be in .venv if i use mise i need to install packages to that python version

## TL;DR (Recommended Setup)

✅ Use **`mise` per project**
✅ Create a **`.venv` inside the project**
✅ Let **Pyright auto-detect the venv**

❌ Avoid global Python overrides
❌ Avoid hardcoding `pythonPath` unless absolutely required

---

## Method 1 — Project-local Virtual Environment (Recommended) [ this method is good for long term ]

This is the **cleanest and safest** approach and works perfectly with LazyVim.

---

### 1. Create a project directory

```bash
mkdir ~/project_name
cd ~/project_name
```

---

### 2. Create a virtual environment

#### Using `mise` [if you want a setup like this

projectA/
mise → Python 3.9
.venv → numpy 1.21

projectB/
mise → Python 3.14
.venv → numpy 2.4]

```bash
mise use python@3.14
python -m venv .venv
```

> Replace `3.14.2` with the Python version required for the project.

#### Without `mise`

```bash
python3.11 -m venv .venv

```

[ the command mentioned above is not about pyhton version so run the command below to check for avlabile python commands ]

```bash
compgen -c python

```

---

### 3. Activate the virtual environment [ i need to do it each time i open a new terminal if i need to run the file viva the opened new terminal. pyright only needs it one time ]

```bash
source .venv/bin/activate #alias sv in .bashrc
```

---

### 4. Install Neovim Python support [ run these commands inside .venv viva terminal and also pip install package-name for that packages ]

```bash
pip install --upgrade pip #run these inside .venv viva terminal
pip install pynvim
```

 <!-- NOTE: -->: even if i use mise or not if i follow first method then i should install each package like numpy viva pip into the .venv viva terminal

### 5. Configure Pyright (Recommended) [ do this if pyright fail to automatically detect python]

Create a **`pyrightconfig.json`** file in the project root:

```json
{
  "venvPath": ".",
  "venv": ".venv"
}
```

✔ No absolute paths
✔ Portable across systems
✔ Works perfectly with `mise`

---

### 6. Daily workflow [ Required for terminal usage, not necessary for Pyright in Neovim ]

Each time you enter the project :

```bash
source .venv/bin/activate

```

[
mise use python@3.11 # choose Python version
python -m venv .venv # create environment
source .venv/bin/activate # activate (for terminal)
pip install numpy # install INSIDE .venv
]

(Optional: automate this later using `direnv`)

---

---

## Method 2 — `mise` Workflow

---

### 1. Install Python versions via `mise`

```bash
mise install python@3.9
mise install python@3.11
```

---

### 2. Set Python per project (IMPORTANT)

```bash
mise use python@3.9
```

This creates a `mise.toml` **inside the project directory**.

❌ **Do NOT use**

```bash
mise use -g python@3.9
```

#### Why global Python is bad

- Breaks system tools
- Causes module conflicts
- Unpredictable behavior across projects

---

### 3. (Optional) Absolute Python path for Pyright

Only use this if Pyright fails to detect Python automatically.

```json
{
  "venvPath": ".",
  "venv": ".venv"
}
```

List Python versions installed via `mise`:

```bash
mise ls python
```

⚠ **Warning**

- `mise` overrides `pythonpath`
- Prefer `.venv` + `pyrightconfig.json`

---

## Final Recommendation

✔ **Best setup**

- `mise use python@X.Y` (per project)
- `.venv` inside the project
- `pyrightconfig.json` with `venvPath`

✔ **Avoid**

- Global Python overrides
- Hardcoded `pythonPath`
- Mixing system Python with `mise`

---

## Optional Improvements

- Use `direnv` to auto-activate `.venv`
- Add `.venv/` to `.gitignore`
- Run `:LspInfo` to verify Pyright Python
- Run `:checkhealth provider` to debug Neovim Python provider

---

### Rule of Thumb

> One project → one Python → one virtual environment
