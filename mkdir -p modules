#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Root Check"
if command -v su >/dev/null 2>&1; then
    su -c "id" | grep -q uid=0 && echo "[✓] ROOT AKTIF" || echo "[✗] ROOT TIDAK TERDETEKSI"
else
    echo "[!] Tidak ada akses root"
fi
echo
read -p "Tekan Enter untuk kembali ke menu..."
exec ../main.sh
