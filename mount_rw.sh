#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

MODUL="Mount /system RW"
echo "[*] Menjalankan $MODUL"
loading

need_root
tsu -c "mount -o rw,remount /system || mount -o rw,remount /"
mount | grep system

back
