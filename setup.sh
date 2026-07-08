#!/bin/bash
set -e

echo '[1/3] Installing 9router...'
npm install -g 9router

echo '[2/3] Patching RAM limit (6144MB -> 512MB)...'
sed -i 's/--max-old-space-size=6144/--max-old-space-size=512/' /usr/local/lib/node_modules/9router/cli.js

echo '[3/3] Installing systemd service...'
cp 9router.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable 9router
systemctl start 9router

echo 'Done! 9router running at http://localhost:20128'
