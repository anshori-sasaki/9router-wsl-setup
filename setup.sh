#!/bin/bash
set -e

echo '========================================'
echo ' 9Router WSL Setup — root installer'
echo '========================================'

if [ "$(id -u)" -ne 0 ]; then
  echo "Error: script ini HARUS dijalankan sebagai root."
  echo ""
  echo "  WSL instance dengan default user root:"
  echo "    wsl -d <distro> --user root ./setup.sh"
  echo ""
  echo "  Atau jalankan langsung di shell WSL:"
  echo "    sudo ./setup.sh"
  exit 1
fi

echo '=== [1/7] apt update & upgrade ==='
apt update
apt upgrade -y

echo '=== [2/7] Install dependencies (curl, git, etc) ==='
apt install -y ca-certificates curl gnupg git

echo '=== [3/7] Install Node.js 22.x via NodeSource ==='
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/keyrings/nodesource.list
apt update
apt install -y nodejs

corepack enable
corepack prepare npm@latest --activate

echo "Node.js $(node -v), npm $(npm -v)"

echo '=== [4/7] Install 9router global ==='
npm install -g 9router

echo '=== [5/7] Patch RAM limit (6144MB -> 512MB) ==='
sed -i 's/--max-old-space-size=6144/--max-old-space-size=512/' /usr/lib/node_modules/9router/cli.js

echo '=== [6/7] Install systemd service ==='
cp 9router.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable 9router
systemctl start 9router

echo '=== [7/7] Verifikasi ==='
sleep 2
systemctl status 9router --no-pager

echo '========================================'
echo ' Setup selesai!'
echo ' Akses: http://localhost:20128'
echo '========================================'
