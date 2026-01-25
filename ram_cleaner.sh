#!/system/bin/sh
su -c "sync; echo 3 > /proc/sys/vm/drop_caches"
echo "[✓] RAM CLEANED"
read -p "Enter..."
exec ../main.sh
