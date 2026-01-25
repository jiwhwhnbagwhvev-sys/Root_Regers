#!/system/bin/sh
su -c "sysctl -w net.ipv4.tcp_congestion_control=bbr" >/dev/null
su -c "sysctl -w net.core.default_qdisc=fq" >/dev/null
echo "[✓] NETWORK BOOST"
read -p "Enter..."
exec ../main.sh
