# 9Router WSL Setup

9Router AI Proxy di WSL2 dengan fix RAM.

## Problem

9Router spawns Next.js dengan `--max-old-space-size=6144` (6GB). Di WSL2 dengan RAM terbatas (<2GB), proses langsung **OOM-killed**.

## Fix

Turunkan `max-old-space-size` dari 6144 → 512MB di `/usr/local/lib/node_modules/9router/cli.js`.

## Instalasi

```bash
git clone https://github.com/anshori-sasaki/9router-wsl-setup.git
cd 9router-wsl-setup
chmod +x setup.sh
sudo ./setup.sh
```

Akses: http://localhost:20128
