#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

header "CPU PERFORMANCE & GOVERNOR CONTROL"

need_root || exit

echo "[*] Mendeteksi CPU core..."
sleep 0.5

CPU_PATH="/sys/devices/system/cpu"
CORES=$(ls -d $CPU_PATH/cpu[0-9]* 2>/dev/null | wc -l)

echo "[✓] Total CPU core terdeteksi: $CORES"
line

echo "[*] Status governor saat ini:"
for gov in $CPU_PATH/cpu*/cpufreq/scaling_governor; do
  core=$(basename "$(dirname "$gov")")
  cur=$($ROOTCMD -c "cat $gov" 2>/dev/null)
  printf "  - %-5s : %s\n" "$core" "$cur"
done

line
echo "Pilih mode CPU:"
echo "1. Performance (maksimal)"
echo "2. Powersave (hemat)"
echo "3. Interactive (default)"
echo "0. Batal"
read -p "Pilihan: " mode

case $mode in
  1) GOV="performance" ;;
  2) GOV="powersave" ;;
  3) GOV="interactive" ;;
  0) pause; exit ;;
  *) echo "[!] Pilihan tidak valid"; pause; exit ;;
esac

echo
echo "[*] Menerapkan governor: $GOV"
sleep 0.5

for gov in $CPU_PATH/cpu*/cpufreq/scaling_governor; do
  $ROOTCMD -c "echo $GOV > $gov" 2>/dev/null &
done
spinner

echo
echo "[*] Verifikasi ulang:"
for gov in $CPU_PATH/cpu*/cpufreq/scaling_governor; do
  core=$(basename "$(dirname "$gov")")
  cur=$($ROOTCMD -c "cat $gov" 2>/dev/null)
  printf "  - %-5s : %s\n" "$core" "$cur"
done

line
echo -e "${GRN}[✓] CPU TWEAK SELESAI — MODE $GOV AKTIF${RST}"
pause
