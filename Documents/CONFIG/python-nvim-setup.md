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

## TL;DR (Recommended Setup)

✅ Use **`mise` per project**
✅ Create a **`.venv` inside the project**
✅ Let **Pyright auto-detect the venv**

❌ Avoid global Python overrides
❌ Avoid hardcoding `pythonPath` unless absolutely required

---

## Method 1 — Project-local Virtual Environment (Recommended)

This is the **cleanest and safest** approach and works perfectly with LazyVim.

---

### 1. Create a project directory

```bash
mkdir ~/project_name
cd ~/project_name
```

---

### 2. Create a virtual environment

#### Using `mise`

```bash
~/.local/share/mise/installs/python/3.14.2/bin/python3.14 -m venv .venv
```

> Replace `3.14.2` with the Python version required for the project.

#### Without `mise`

```bash
python3.11 -m venv .venv
```

---

### 3. Activate the virtual environment

```bash
source .venv/bin/activate
```

---

### 4. Install Neovim Python support

```bash
pip install --upgrade pip
pip install pynvim
```

---

### 5. Configure Pyright (Recommended)

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

### 6. Daily workflow

Each time you enter the project:

```bash
source .venv/bin/activate
```

(Optional: automate this later using `direnv`)

---

---

## Method 2 — Proper `mise` Workflow (Best Long-Term Solution)

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
  "pythonPath": "/home/bibin/.local/share/mise/installs/python/3.9.25/bin/python"
}
```

List Python versions installed via `mise`:

```bash
mise list python
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
