#!/system/bin/sh
su -c id | grep -q uid=0 && echo "[✓] ROOT AKTIF" || echo "[✗] ROOT OFF"
read -p "Enter..."
exec ../main.sh
