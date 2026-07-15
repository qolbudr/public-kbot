#!/bin/bash
# install.sh

cd ~
termux-setup-storage

# Hapus folder kbot lama dari internal storage
rm -rf /storage/emulated/0/Kbot

pkg update -y
yes | pkg upgrade -y
pkg install proot-distro wget unzip -y
proot-distro install ubuntu
proot-distro login ubuntu -- bash -c "apt update -y && apt install wget unzip -y"

# Download accounts folder
mkdir -p /storage/emulated/0/Kbot
proot-distro login ubuntu -- bash -c "
  wget 'https://github.com/qolbudr/public-kbot/archive/refs/heads/main.zip' -O /tmp/kbot.zip && \
  unzip -q /tmp/kbot.zip 'public-kbot-main/accounts/*' -d /tmp/kbot-extract && \
  cp -r /tmp/kbot-extract/public-kbot-main/accounts /storage/emulated/0/Kbot/ && \
  rm -rf /tmp/kbot.zip /tmp/kbot-extract
"

# Download binary
proot-distro login ubuntu -- bash -c "
  wget 'https://github.com/qolbudr/public-kbot/raw/refs/heads/main/binary/kbot-linux-arm' -O ~/kbot-linux-arm && \
  chmod +x ~/kbot-linux-arm
"

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
echo "✅ Instalasi selesai!"
bash ~/symlink.sh < /dev/tty
