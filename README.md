# 9Router WSL Setup

9Router AI Proxy di WSL2.

## Prerequisites

- WSL2 dengan systemd (Ubuntu 24.04+ atau Ubuntu 26+)
- **Default user: root** (script ini berjalan sebagai root)

## Cara Pakai

```bash
# Clone repo
git clone https://github.com/anshori-sasaki/9router-wsl-setup.git
cd 9router-wsl-setup

# Jalankan sebagai root
./setup.sh
```

Script akan:
1. `apt update && apt upgrade`
2. Install Node.js 22.x dari NodeSource + npm via corepack
3. Install 9Router secara global
4. Patch `max-old-space-size` dari 6144MB ke 512MB (agar tidak OOM di WSL dengan RAM terbatas)
5. Install systemd service dan start 9Router

## Akses

http://localhost:20128

## Catatan

- `HOSTNAME=0.0.0.0` agar bisa diakses dari Windows
- 9Router berjalan di port **20128**
- Service otomatis restart jika crash (`Restart=always`)
