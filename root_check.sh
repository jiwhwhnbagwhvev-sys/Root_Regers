#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

MODUL="Root Check"
echo "[*] Menjalankan $MODUL"
loading

if command -v tsu >/dev/null 2>&1; then
    tsu -c "id"
    echo "[✓] $MODUL berhasil dijalankan"
else
    echo "[!] Root tidak tersedia"
fi

back
