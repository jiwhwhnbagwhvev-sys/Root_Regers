#!/system/bin/sh
# ==========================================
# ROOT CHECK MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="ROOT CHECK"
LOG="/data/local/tmp/root_ragers.log"
TEST_MODE=1

# ---------- COLOR ----------
R="\e[0m"
G="\e[1;32m"
Y="\e[1;33m"
RED="\e[1;31m"
C="\e[1;36m"
B="\e[1m"

# ---------- UTIL ----------
pause() { read -rp "Tekan ENTER untuk kembali..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
clear
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║          ROOT CHECK MODULE           ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Memeriksa sistem"
for i in $(seq 1 15); do
  echo -ne "."
  sleep 0.15
done
echo -e "${R}"
}

# ---------- ROOT CHECK ----------
check_su_binary() {
echo -e "${Y}[*] Mengecek binary su...${R}"
if command -v su >/dev/null 2>&1; then
  echo -e "${G}[✓] su ditemukan${R}"
  log "su binary OK"
  return 0
else
  echo -e "${RED}[✗] su tidak ditemukan${R}"
  log "su binary NOT FOUND"
  return 1
fi
}

check_uid() {
echo -e "${Y}[*] Mengecek UID root...${R}"
UID_TEST=$(su -c "id -u" 2>/dev/null)

if [ "$UID_TEST" = "0" ]; then
  echo -e "${G}[✓] UID = 0 (ROOT)${R}"
  log "UID ROOT OK"
  return 0
else
  echo -e "${RED}[✗] UID bukan root${R}"
  log "UID ROOT FAILED"
  return 1
fi
}

check_system_mount() {
echo -e "${Y}[*] Mengecek mount /system...${R}"
SYS_MOUNT=$(mount | grep " /system ")

if echo "$SYS_MOUNT" | grep -q "rw"; then
  echo -e "${G}[✓] /system RW${R}"
  log "/system RW"
else
  echo -e "${Y}[!] /system RO${R}"
  log "/system RO"
fi
}

check_write_access() {
echo -e "${Y}[*] Tes tulis dummy...${R}"
TEST_FILE="/data/local/tmp/.root_test"

su -c "echo test > $TEST_FILE" 2>/dev/null

if su -c "[ -f $TEST_FILE ]"; then
  echo -e "${G}[✓] Akses tulis berhasil${R}"
  su -c "rm -f $TEST_FILE"
  log "WRITE ACCESS OK"
  return 0
else
  echo -e "${RED}[✗] Akses tulis gagal${R}"
  log "WRITE ACCESS FAILED"
  return 1
fi
}

# ---------- AUTO TEST ----------
auto_test() {
[ "$TEST_MODE" != "1" ] && return

echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║           AUTO TEST MODE             ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

TEMP_PATH="/sys/class/thermal/thermal_zone0/temp"

[ ! -f "$TEMP_PATH" ] && {
  echo -e "${Y}[!] Sensor suhu tidak tersedia${R}"
  return
}

TEMP_BEFORE=$(cat "$TEMP_PATH")
TEMP_BEFORE=$((TEMP_BEFORE / 1000))

echo " Suhu awal : ${TEMP_BEFORE}°C"
echo -e "${Y}[*] Stress test ringan...${R}"

for i in {1..2}; do
  yes > /dev/null &
done

sleep 4
killall yes 2>/dev/null

TEMP_AFTER=$(cat "$TEMP_PATH")
TEMP_AFTER=$((TEMP_AFTER / 1000))

echo " Suhu akhir: ${TEMP_AFTER}°C"

if [ "$TEMP_AFTER" -gt "$TEMP_BEFORE" ]; then
  echo -e "${G}[✓] AUTO TEST BERHASIL${R}"
  log "AUTO TEST OK"
else
  echo -e "${Y}[!] AUTO TEST TIDAK TERDETEKSI${R}"
  log "AUTO TEST NO CHANGE"
fi
}

# ---------- MAIN ----------
main() {
header
progress

check_su_binary || { echo -e "${RED}ROOT INVALID${R}"; pause; exit 1; }
check_uid        || { echo -e "${RED}ROOT INVALID${R}"; pause; exit 1; }
check_system_mount
check_write_access || { echo -e "${RED}ROOT TERBATAS${R}"; pause; exit 1; }

echo -e "${G}${B}"
echo "✔ ROOT VALID — DEVICE SIAP DIGUNAKAN"
echo -e "${R}"

auto_test
pause
}

main
