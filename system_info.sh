#!/data/data/com.termux/files/usr/bin/bash
echo "[*] System Info"
getprop ro.product.model
getprop ro.build.version.release
getprop ro.product.cpu.abi
uptime
free -h
echo
echo "Tekan Enter untuk kembali..."
read
exec ../main.sh
