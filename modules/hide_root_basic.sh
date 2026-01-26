#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# BASIC ROOT HIDE MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="BASIC ROOT HIDE"
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
echo "║          BASIC ROOT HIDE MODULE      ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Menyembunyikan akses root"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Hanya simulasi${R}"
  log "ROOT NOT DETECTED"
  exit 1
else
  echo -e "${G}[✓] ROOT TERDETEKSI — Bisa sembunyikan root${R}"
  log "ROOT OK"
fi
}

hide_root() {
echo -e "${Y}[*] Menyembunyikan root apps dan binari...${R}"
sleep 0.3

# Contoh simulasi hide root: rename su binary
if [ -f "/system/xbin/su" ]; then
    su -c "mv /system/xbin/su /system/xbin/su_hidden 2>/dev/null" && \
    echo -e "${G}[✓] Root binary disembunyikan${R}" && log "su hidden"
else
    echo -e "${Y}[!] Root binary tidak ditemukan / sudah tersembunyi${R}" && log "su not found"
fi
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║           AUTO TEST ROOT HIDE        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

if [ ! -f "/system/xbin/su" ]; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — Root berhasil disembunyikan${R}"
    log "AUTO TEST OK: Root hidden"
else
    echo -e "${RED}[✗] AUTO TEST FAILED — Root binary masih ada${R}"
    log "AUTO TEST FAILED: Root still visible"
fi
sleep 0.5
}

main() {
header
check_root
progress
hide_root
progress
auto_test
pause
}

main
