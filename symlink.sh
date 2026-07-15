#!/bin/bash
# symlink.sh

exec < /dev/tty

ACCOUNT_PATH="/storage/emulated/0/Kbot"

exec proot-distro login ubuntu \
    --bind "$ACCOUNT_PATH":/root/accounts \
    -- bash -c "chmod +x ~/kbot-linux-arm && ~/kbot-linux-arm"
