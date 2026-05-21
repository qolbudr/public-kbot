cd ~
pkg update -y
yes | pkg upgrade -y
pkg install proot-distro -y
proot-distro install ubuntu
proot-distro login ubuntu -- bash -c "apt update -y && apt install git -y"
proot-distro login ubuntu -- bash -c "cd ~ && git clone https://github.com/qolbudr/public-kbot.git ~/kbot-tmp"
proot-distro login ubuntu -- bash -c "cd /storage/emulated/0 && rm -rf *kbot*"
proot-distro login ubuntu -- bash -c "mkdir -p /storage/emulated/0/kbot-main/1 && mv ~/kbot-tmp/accounts /storage/emulated/0/kbot-main/1 && mv ~/kbot-tmp/binary/kbot-linux-arm ~ && chmod +x ~/kbot-linux-arm"
proot-distro login ubuntu -- bash -c "ln -s /storage/emulated/0/kbot-main/1/accounts ~/accounts"
proot-distro login ubuntu -- bash -c "rm -rf ~/kbot-tmp"
proot-distro login ubuntu -- bash -c "curl -fsSL https://raw.githubusercontent.com/qolbudr/public-kbot/refs/heads/main/symlink.sh -o symlink.sh && chmod +x symlink.sh"
proot-distro login ubuntu -- bash -c "echo '~/symlink.sh' >> ~/.bashrc"
echo 'proot-distro login ubuntu' >> ~/.bashrc