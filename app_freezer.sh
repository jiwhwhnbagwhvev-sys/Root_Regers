#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# APP FREEZER MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="APP FREEZER"
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
echo "║            APP FREEZER MODULE        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

check_root() {
if ! command -v pm >/dev/null 2>&1 || ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI / PM TOOL TIDAK ADA${R}"
  log "ROOT NOT DETECTED OR PM NOT FOUND"
  exit 1
fi
echo -e "${G}[✓] ROOT TERDETEKSI${R}"
log "ROOT OK"
}

list_apps() {
echo -e "${Y}[*] Daftar aplikasi user:${R}"
APPS=($(pm list packages -3 | cut -d: -f2))
for i in "${!APPS[@]}"; do
  printf " %2d. %s\n" $((i+1)) "${APPS[$i]}"
done
}

freeze_app() {
read -rp "Masukkan nomor aplikasi untuk freeze (atau q untuk keluar): " sel
[[ "$sel" =~ ^[qQ]$ ]] && return
INDEX=$((sel-1))
APP=${APPS[$INDEX]}
if [ -z "$APP" ]; then
  echo -e "${RED}[✗] Pilihan salah${R}"
  freeze_app
  return
fi
echo -e "${Y}[*] Freezing $APP ...${R}"
su -c "pm disable-user --user 0 $APP" >/dev/null 2>&1
if pm list packages -d | grep -q "$APP"; then
  echo -e "${G}[✓] $APP berhasil di-freeze${R}"
  log "$APP frozen"
else
  echo -e "${RED}[✗] $APP gagal di-freeze${R}"
  log "$APP freeze FAILED"
fi
pause
}

main() {
header
check_root
while true; do
  list_apps
  freeze_app
done
}

main
