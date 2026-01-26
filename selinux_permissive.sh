#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# SELINUX PERMISSIVE MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="SELINUX PERMISSIVE"
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
echo "║        SELINUX PERMISSIVE MODULE     ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Mengubah mode SELinux"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Tidak bisa ubah SELinux${R}"
  log "ROOT NOT DETECTED"
  exit 1
else
  echo -e "${G}[✓] ROOT TERDETEKSI — Bisa ubah SELinux${R}"
  log "ROOT OK"
fi
}

set_permissive() {
echo -e "${Y}[*] Mengubah SELinux ke mode Permissive...${R}"
sleep 0.3

if command -v setenforce >/dev/null 2>&1; then
    su -c "setenforce 0"
    echo -e "${G}[✓] SELinux sekarang PERMISSIVE${R}"
    log "SELinux set to PERMISSIVE"
else
    echo -e "${RED}[✗] Perintah setenforce tidak tersedia${R}"
    log "SELinux PERMISSIVE FAILED"
fi
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║          AUTO TEST SELINUX           ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

STATUS=$(getenforce 2>/dev/null)
if [ "$STATUS" = "Permissive" ]; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — SELinux PERMISSIVE${R}"
    log "AUTO TEST OK: SELinux PERMISSIVE"
else
    echo -e "${RED}[✗] AUTO TEST FAILED — SELinux masih $STATUS${R}"
    log "AUTO TEST FAILED: SELinux $STATUS"
fi
sleep 0.5
}

main() {
header
check_root
progress
set_permissive
progress
auto_test
pause
}

main
