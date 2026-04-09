---
id: ssh_git
aliases: []
tags: []
---

[[VLC]]
[[plymouth]]
[[python-nvim-setup]]
[[Render-markdown]]

#  Complete Linux SSH + GitHub SSH + Fail2Ban Guide

This document includes:

- GitHub SSH key setup
- Switching Git to SSH
- SSH server hardening
- Fail2Ban installation and configuration
- banip / unbanip explanation
- Troubleshooting
- Security best practices

---

#  GitHub SSH Setup

---

## Check Existing SSH Keys

```bash
ls ~/.ssh
```

Look for:

- id_ed25519
- id_ed25519.pub
- id_rsa
- id_rsa.pub

If they exist, you may reuse them.

---

## Generate New SSH Key (Recommended: ed25519)

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Press Enter for default location.

This creates:

```
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
```

---

## Start SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Verify:

```bash
ssh-add -l
```

---

## Copy Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire output.

---

## Add Key to GitHub

Go to:

<https://github.com/settings/keys>

1. Click **New SSH Key**
2. Add title (e.g., "My Laptop")
3. Paste public key
4. Save

---

## Test SSH Connection

```bash
ssh -T git@github.com
```

First time:

```
Are you sure you want to continue connecting?
```

Type:

```
yes
```

Successful output:

```
Hi USERNAME! You've successfully authenticated...
```

---

## Make Git Use SSH Instead of HTTPS

Check:

```bash
git remote -v
```

If HTTPS:

```bash
git remote set-url origin git@github.com:USERNAME/REPO.git
```

---

## Optional SSH Config File

Edit:

```bash
nano ~/.ssh/config
```

Add:

```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
```

Secure it:

```bash
chmod 600 ~/.ssh/config
```

---

#  SSH Server Hardening

---

## Edit SSH Config

```bash
sudo nano /etc/ssh/sshd_config
```

---

## Disable Root Login

```
PermitRootLogin no
```

---

## Disable Password Authentication (Recommended)

```
PasswordAuthentication no
```

⚠ Only disable passwords AFTER confirming SSH keys work.

Restart SSH:

```bash
sudo systemctl restart sshd
```

---

## Optional: Change SSH Port

```
Port 2222
```

Restart:

```bash
sudo systemctl restart sshd
```

---

#  Install and Configure Fail2Ban

Fail2Ban blocks IPs after repeated failed login attempts.

---

## Install

### Arch Linux

```bash
sudo pacman -S fail2ban
```

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install fail2ban
```

---

## Enable and Start

```bash
sudo systemctl enable --now fail2ban
```

Check:

```bash
sudo systemctl status fail2ban
```

---

## Create jail.local (DO NOT edit jail.conf)

```bash
sudo nano /etc/fail2ban/jail.local
```

Add:

```
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
backend = systemd

[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
```

Restart:

```bash
sudo systemctl restart fail2ban
```

---

## Check Status

```bash
sudo fail2ban-client status
```

Check SSH jail:

```bash
sudo fail2ban-client status sshd
```

---

#  Understanding banip and unbanip

---

## Manually Ban an IP

```bash
sudo fail2ban-client set sshd banip 192.168.1.100
```

---

## Manually Unban an IP

```bash
sudo fail2ban-client set sshd unbanip 192.168.1.100
```

Important:

- `unbanip` removes current block
- It does NOT permanently whitelist
- IP can be banned again later

---

## Whitelist an IP (Ignore)

Edit jail.local:

```
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1 192.168.1.100
```

Restart:

```bash
sudo systemctl restart fail2ban
```

---

#  Troubleshooting

---

## Permission Denied (publickey)

```bash
ssh-add ~/.ssh/id_ed25519
```

---

## Debug SSH

```bash
ssh -vT git@github.com
```

---

## Check Banned IPs

```bash
sudo fail2ban-client status sshd
```

---

## Unban Yourself

```bash
sudo fail2ban-client set sshd unbanip YOUR_IP
```

---

## Check SSH Agent

```bash
echo $SSH_AUTH_SOCK
```

If empty:

```bash
eval "$(ssh-agent -s)"
```

---

#  File Permissions Best Practices

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/config
```

Never share:

```
id_ed25519
```

Only share:

```
id_ed25519.pub
```

---

# 7️⃣ Security Summary

| Feature                | Purpose               |
| ---------------------- | --------------------- |
| SSH Keys               | Strong authentication |
| Disable Password Login | Prevent brute force   |
| Disable Root Login     | Reduce attack surface |
| Fail2Ban               | Auto-block attackers  |
| Change SSH Port        | Reduce bot noise      |

---

# Final Checklist

- [x] SSH key generated
- [x] Key added to GitHub
- [x] SSH tested successfully
- [ ] Git remote converted to SSH
- [ ] Root login disabled
- [ ] Password login disabled
- [ ] Fail2Ban installed
- [ ] Jail configured
- [ ] Service running
- [x] add a line

---

#  Done

Your system is now:

- Securely authenticated with GitHub
- Hardened against SSH brute-force attacks
- Automatically blocking malicious IPs
