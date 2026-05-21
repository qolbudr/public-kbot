while true; do
    clear
    read -p 'Enter account folder [default: 1]: ' num
    num=${num:-1}

    if [[ "$num" =~ ^[0-9]+$ ]]; then
        ACCOUNT_PATH="/storage/emulated/0/kbot-main/$num/accounts"

        if [ -d "$ACCOUNT_PATH" ]; then
            break
        else
            read -p "Folder not found. Create it? (y/n): " confirm

            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                mkdir -p "$ACCOUNT_PATH"
                echo "Created $ACCOUNT_PATH"
                break
            fi
        fi
    else
        echo 'Invalid input. Please enter a number.'
        sleep 1
    fi
done

rm -f ~/accounts
ln -s "$ACCOUNT_PATH" ~/accounts

~/kbot-linux-arm