#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# SERVICE MANAGER MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="SERVICE MANAGER"
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
echo "║          SERVICE MANAGER MODULE      ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Memuat daftar service"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Hanya read-only${R}"
  log "ROOT NOT DETECTED"
  exit 1
else
  echo -e "${G}[✓] ROOT TERDETEKSI — Bisa kelola service${R}"
  log "ROOT OK"
fi
}

list_services() {
echo -e "${Y}[*] Daftar service aktif di device:${R}"
sleep 0.3
su -c "service --status-all 2>/dev/null" | awk '{print $0}' | tee /data/local/tmp/service_list.log
log "Listed services"
}

stop_service() {
read -rp "Masukkan nama service untuk dihentikan: " SVC
if [ -n "$SVC" ]; then
    su -c "service $SVC stop" 2>/dev/null && \
    echo -e "${G}[✓] Service $SVC dihentikan${R}" && log "Service $SVC stopped"
fi
}

start_service() {
read -rp "Masukkan nama service untuk dijalankan: " SVC
if [ -n "$SVC" ]; then
    su -c "service $SVC start" 2>/dev/null && \
    echo -e "${G}[✓] Service $SVC dijalankan${R}" && log "Service $SVC started"
fi
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║          AUTO TEST SERVICE           ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
TEST_SVC="cron"
if su -c "service $TEST_SVC status" &>/dev/null; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — $TEST_SVC service terdeteksi${R}"
    log "AUTO TEST OK: $TEST_SVC service detected"
else
    echo -e "${Y}[!] AUTO TEST NOTICE — $TEST_SVC service tidak aktif${R}"
    log "AUTO TEST NOTICE: $TEST_SVC not running"
fi
sleep 0.5
}

main() {
header
check_root
progress
list_services

while true; do
    echo -e "${Y}Pilih opsi:${R}"
    echo "1) Hentikan service"
    echo "2) Jalankan service"
    echo "0) Kembali ke menu"
    read -rp "Pilihan: " opt
    case $opt in
        1) stop_service ;;
        2) start_service ;;
        0) break ;;
        *) echo -e "${RED}[!] Pilihan salah${R}" ;;
    esac
done

progress
auto_test
pause
}

main
