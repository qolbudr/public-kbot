# Pastikan folder Kbot ada
mkdir -p /storage/emulated/0/Kbot

# Jika folder accounts ada, pindahkan seluruh isinya ke Kbot
if [ -d /storage/emulated/0/kbot-main/1/accounts ]; then
    mv /storage/emulated/0/kbot-main/1/accounts/* /storage/emulated/0/Kbot/ 2>/dev/null
fi

# Pindahkan sisa isi folder 1 ke Kbot (jika ada)
if [ -d /storage/emulated/0/kbot-main ]; then
    mv /storage/emulated/0/kbot-main/* /storage/emulated/0/Kbot/ 2>/dev/null
fi

# Hapus folder sementara
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
