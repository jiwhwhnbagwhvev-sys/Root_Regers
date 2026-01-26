#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

MODUL="Freeze App"
echo "[*] Menjalankan $MODUL"
loading

read -p "Nama package: " p
need_root
tsu -c "pm disable-user --user 0 $p"

back
