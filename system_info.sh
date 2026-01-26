#!/data/data/com.termux/files/usr/bin/bash
echo "[*] System Info"
getprop ro.product.model
getprop ro.build.version.release
getprop ro.product.cpu.abi
uptime
free -h
read -p "Enter untuk kembali atau q untuk keluar: " c
[[ "$c" =~ ^[qQ]$ ]] && exit || return
