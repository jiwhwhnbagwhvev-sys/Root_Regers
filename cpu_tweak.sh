#!/system/bin/sh
for c in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  su -c "echo performance > $c" 2>/dev/null
done
echo "[✓] CPU PERFORMANCE"
read -p "Enter..."
exec ../main.sh
