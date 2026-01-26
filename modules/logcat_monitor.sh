#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# LOGCAT MONITOR MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="LOGCAT MONITOR"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"
G="\e[1;32m"
Y="\e[1;33m"
RED="\e[1;31m"
C="\e[1;36m"
B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
clear
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║         LOGCAT MONITOR MODULE        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Menginisialisasi Logcat"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Logcat terbatas${R}"
  log "ROOT NOT DETECTED"
else
  echo -e "${G}[✓] ROOT TERDETEKSI — Logcat penuh tersedia${R}"
  log "ROOT OK"
fi
}

monitor_logcat() {
echo -e "${Y}[*] Memulai monitoring logcat... Tekan CTRL+C untuk berhenti${R}"
log "Started logcat monitoring"
su -c "logcat -v time | tee /data/local/tmp/logcat_monitor.log"
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║          AUTO TEST LOGCAT            ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

TEST_FILE="/data/local/tmp/logcat_monitor.log"
touch $TEST_FILE 2>/dev/null
if [ -w "$TEST_FILE" ]; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — Logcat dapat diakses${R}"
    log "AUTO TEST OK: Logcat writable"
else
    echo -e "${RED}[✗] AUTO TEST FAILED — Logcat tidak dapat diakses${R}"
    log "AUTO TEST FAILED: Logcat write failed"
fi
rm -f $TEST_FILE
sleep 0.5
}

main() {
header
check_root
progress
auto_test
monitor_logcat
pause
}

main
