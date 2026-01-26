#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# SELINUX STATUS MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="SELINUX STATUS"
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
echo "║          SELINUX STATUS MODULE       ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Mengecek SELinux"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Hanya status read-only${R}"
  log "ROOT NOT DETECTED"
else
  echo -e "${G}[✓] ROOT TERDETEKSI — Status SELinux bisa dicek penuh${R}"
  log "ROOT OK"
fi
}

selinux_check() {
echo -e "${Y}[*] Memeriksa status SELinux...${R}"
sleep 0.5

if command -v getenforce >/dev/null 2>&1; then
    STATUS=$(getenforce)
    echo -e "${G}[✓] SELinux Mode: ${STATUS}${R}"
    log "SELinux Mode: ${STATUS}"
else
    echo -e "${RED}[!] Perintah getenforce tidak tersedia${R}"
    log "SELinux check FAILED"
fi
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║            AUTO TEST SELINUX         ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

# Test read / enforcing
if [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — SELinux Enforcing${R}"
    log "SELinux AUTO TEST OK"
else
    echo -e "${Y}[!] AUTO TEST NOTICE — SELinux tidak Enforcing${R}"
    log "SELinux AUTO TEST NOTICE"
fi
sleep 0.5
}

main() {
header
check_root
progress
selinux_check
progress
auto_test
pause
}

main
