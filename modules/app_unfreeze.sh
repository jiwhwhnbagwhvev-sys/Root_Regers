#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# APP UNFREEZE MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="APP UNFREEZE"
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
echo "║           APP UNFREEZE MODULE        ║"
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

list_disabled_apps() {
echo -e "${Y}[*] Daftar aplikasi yang di-disable:${R}"
DISABLED=($(pm list packages -d | cut -d: -f2))
if [ ${#DISABLED[@]} -eq 0 ]; then
  echo -e "${Y}[!] Tidak ada aplikasi yang di-freeze${R}"
  return 1
fi
for i in "${!DISABLED[@]}"; do
  printf " %2d. %s\n" $((i+1)) "${DISABLED[$i]}"
done
return 0
}

unfreeze_app() {
read -rp "Masukkan nomor aplikasi untuk unfreeze (atau 'a' untuk semua, q untuk keluar): " sel
[[ "$sel" =~ ^[qQ]$ ]] && return 1
if [[ "$sel" =~ ^[aA]$ ]]; then
  echo -e "${Y}[*] Mengaktifkan semua aplikasi...${R}"
  for APP in "${DISABLED[@]}"; do
    su -c "pm enable $APP" >/dev/null 2>&1
    if pm list packages -e | grep -q "$APP"; then
      echo -e "${G}[✓] $APP berhasil di-unfreeze${R}"
      log "$APP unfreeze OK"
    else
      echo -e "${RED}[✗] $APP gagal di-unfreeze${R}"
      log "$APP unfreeze FAILED"
    fi
  done
  pause
  return 0
fi

INDEX=$((sel-1))
APP=${DISABLED[$INDEX]}
if [ -z "$APP" ]; then
  echo -e "${RED}[✗] Pilihan salah${R}"
  unfreeze_app
  return
fi

echo -e "${Y}[*] Mengaktifkan $APP ...${R}"
su -c "pm enable $APP" >/dev/null 2>&1
if pm list packages -e | grep -q "$APP"; then
  echo -e "${G}[✓] $APP berhasil di-unfreeze${R}"
  log "$APP unfreeze OK"
else
  echo -e "${RED}[✗] $APP gagal di-unfreeze${R}"
  log "$APP unfreeze FAILED"
fi
pause
}

main() {
header
check_root
while true; do
  if list_disabled_apps; then
    unfreeze_app || break
  else
    pause
    break
  fi
done
}

main
