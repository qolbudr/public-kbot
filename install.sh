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

proot-distro login ubuntu -- bash -c "
cat << 'EOF' > ~/setup-symlink.sh
while true; do
    clear
    read -p 'Enter account folder [default: 1]: ' num
    num=\${num:-1}
    if [[ \"\$num\" =~ ^[0-9]+\$ ]]; then
        ACCOUNT_PATH=\"/storage/emulated/0/kbot-main/\$num/accounts\"
        if [ -d \"\$ACCOUNT_PATH\" ]; then
            break
        else
            read -p \"Folder not found. Create it? (y/n): \" confirm
            if [[ \"\$confirm\" == 'y' || \"\$confirm\" == 'Y' ]]; then
                mkdir -p \"\$ACCOUNT_PATH\"
                echo \"Created \$ACCOUNT_PATH\"
                break
            fi
        fi
    else
        echo 'Invalid input. Please enter a number.'
    fi
done
rm -f ~/accounts
ln -s \"\$ACCOUNT_PATH\" ~/accounts
~/kbot-linux-arm
EOF
chmod +x ~/setup-symlink.sh
"

proot-distro login ubuntu -- bash -c "echo '~/setup-symlink.sh' > ~/.bashrc && source ~/.bashrc"
echo 'proot-distro login ubuntu' > ~/.bashrc && source ~/.bashrc