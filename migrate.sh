rm -rf /storage/emulated/0/Kbot
mv /storage/emulated/0/kbot-main/1 /storage/emulated/0/Kbot
rm -rf /storage/emulated/0/kbot-main

# Download symlink.sh
curl -fsSL https://raw.githubusercontent.com/qolbudr/public-kbot/refs/heads/main/symlink.sh -o ~/symlink.sh
chmod +x ~/symlink.sh

# Setup .bashrc: alias + auto-run (idempotent)
if ! grep -qF '# kbot' ~/.bashrc; then
cat >> ~/.bashrc << 'EOF'

# kbot
alias kbot="bash ~/symlink.sh"
bash ~/symlink.sh < /dev/tty
EOF
fi

echo ""
echo "✅ Migrasi selesai!"
bash ~/symlink.sh < /dev/tty
