#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# REBOOT MENU MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="REBOOT MENU"
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
echo "║           REBOOT MENU MODULE         ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Memproses permintaan"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Reboot terbatas${R}"
  log "ROOT NOT DETECTED"
  exit 1
else
  echo -e "${G}[✓] ROOT TERDETEKSI — Bisa reboot${R}"
  log "ROOT OK"
fi
}

reboot_device() {
echo -e "${Y}[*] Memilih tipe reboot...${R}"
sleep 0.3
echo "1) Reboot Normal"
echo "2) Power Off"
echo "3) Reboot ke Recovery"
echo "4) Reboot ke Bootloader"
echo "0) Kembali"
read -rp "Pilihan: " opt
case $opt in
    1) su -c "reboot" && log "Device rebooting normal" ;;
    2) su -c "poweroff" && log "Device powering off" ;;
    3) su -c "reboot recovery" && log "Device rebooting recovery" ;;
    4) su -c "reboot bootloader" && log "Device rebooting bootloader" ;;
    0) return ;;
    *) echo -e "${RED}[!] Pilihan salah${R}" ;;
esac
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║          AUTO TEST REBOOT            ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
# Cek simulasi izin root
if command -v su >/dev/null 2>&1; then
    echo -e "${G}[✓] AUTO TEST OK — Root siap untuk reboot${R}"
    log "AUTO TEST OK: Root detected for reboot"
else
    echo -e "${RED}[✗] AUTO TEST FAILED — Root tidak tersedia${R}"
    log "AUTO TEST FAILED: Root not detected"
fi
sleep 0.5
}

main() {
header
check_root
progress
reboot_device
progress
auto_test
pause
}

main
