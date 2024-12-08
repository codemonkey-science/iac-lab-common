#!/bin/bash

# Initialize a flag to track if any change was made
change_made=0

# Check if the full hostname is already in the operations prompt
echo "[*] Check if the full hostname is already in the operations prompt"
if grep -Fq '$(hostname -f)' /home/operations/.bashrc; then
    echo "[+] Full hostname is already in the operations prompt."
else
    echo "[*] Show the full hostname in the operations prompt."
    if ! sed -i 's/\\h/$(hostname -f)/g' /home/operations/.bashrc; then
        echo "[!] Error updating /home/operations/.bashrc"
        exit 2
    fi
    source /home/operations/.bashrc
    echo "[*] Changes made to /home/operations/.bashrc"
    change_made=1
fi

# Check if the full hostname is already in the root prompt
echo "[*] Check if the full hostname is already in the root prompt"
if grep -Fq '$(hostname -f)' /root/.bashrc; then
    echo "[+] Full hostname is already in the root prompt."
else
    echo "[*] Copy operations .bashrc to root"
    if ! cp /home/operations/.bashrc /root/; then
        echo "[-] Error copying /home/operations/.bashrc to /root/"
        exit 2
    fi
    echo "[*] Changes made to /root/.bashrc"
    change_made=1
fi

# Check if the root prompt is already red
echo "[*] Check if the root prompt is red"
if grep -Fq '01;31m' /root/.bashrc; then
    echo "[+] Root prompt is already red."
else
    echo "[*] Change the root prompt to be red."
    if ! sed -i 's/01;32m/01;31m/g' /root/.bashrc; then
        echo "[-] Error updating /root/.bashrc"
        exit 2
    fi
    echo "[*] Changes made to /root/.bashrc"
    change_made=1
fi

# If we reach here, return based on whether any change was made
if [ $change_made -eq 1 ]; then
    exit 1
else
    exit 0
fi