#!/system/bin/sh
su -c "setenforce 0"
echo "[✓] SELINUX PERMISSIVE"
read -p "Enter..."
exec ../main.sh
