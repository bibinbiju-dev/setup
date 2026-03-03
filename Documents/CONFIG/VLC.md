---
id: VLC
aliases: []
tags: []
---

[[ssh_git]]
[[plymouth]]
[[python-nvim-setup]]
[[Render-markdown]]

# Fix VLC Issues on Arch Linux

This note covers a **quick and reliable fix** for most VLC playback problems on Arch Linux.

## Common VLC Problems

![test](./assets/img/screenshot-2026-02-15_21-12-57.png)
You may experience one or more of the following:

- VLC opens but does not play videos
- Missing codec or decoding errors
- Videos play without audio
- Error messages related to FFmpeg

Most of these issues are caused by **missing or mismatched FFmpeg plugins**.

---

## Quick Fix (Works in Most Cases)

Install the FFmpeg plugin for VLC:

```bash
sudo pacman -S vlc-plugin-ffmpeg
```

This package provides the required FFmpeg codecs that VLC depends on.

---

## After Installing

1. Close VLC completely
2. Reopen VLC
3. Try playing the video again

In most cases, playback issues are resolved immediately.

---

## If the Problem Persists

Try the following checks:

### 1. Make sure VLC is up to date

```bash
sudo pacman -Syu vlc
```

---

### 2. Check for conflicting FFmpeg versions

```bash
pacman -Qs ffmpeg
```

You should generally have **only one FFmpeg provider** installed.

---

### 3. Reset VLC configuration (last resort)

```bash
rm -rf ~/.config/vlc
```

⚠ This will reset all VLC preferences.

---

## Notes

- Arch Linux splits VLC codecs into separate packages
- `vlc-plugin-ffmpeg` is **not optional** for most media formats
- Missing this package is one of the most common VLC issues on Arch

---

### Rule of Thumb

> VLC problems on Arch? Install `vlc-plugin-ffmpeg` first.
