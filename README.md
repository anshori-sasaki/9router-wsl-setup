# 9Router WSL Setup

9Router AI Proxy di WSL2 dengan fix RAM.

## Problem

9Router spawns Next.js dengan `--max-old-space-size=6144` (6GB). Di WSL2 dengan RAM terbatas (<2GB), proses langsung **OOM-killed**.

## Fix

Turunkan `max-old-space-size` dari 6144 → 512MB di `/usr/local/lib/node_modules/9router/cli.js`:

```diff
- const child = spawn(RUNTIME, ["--max-old-space-size=6144", serverPath], {
+ const child = spawn(RUNTIME, ["--max-old-space-size=512", serverPath], {
```

## Instalasi

```bash
chmod +x setup.sh
sudo ./setup.sh
```

Atau manual:

```bash
npm install -g 9router
sudo sed -i 's/--max-old-space-size=6144/--max-old-space-size=512/' \
  /usr/local/lib/node_modules/9router/cli.js
sudo cp 9router.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now 9router
```

Akses: http://localhost:20128
