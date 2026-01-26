#!/system/bin/sh
# ==========================================
# MOUNT RW MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="MOUNT RW"
LOG="/data/local/tmp/root_ragers.log"
TEST_MODE=1

# ---------- COLOR ----------
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
echo "║             MOUNT RW MODULE          ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Memproses MOUNT RW"
for i in $(seq 1 30); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! su -c "id" >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI${R}"
  log "ROOT FAILED"
  exit 1
fi
echo -e "${G}[✓] ROOT TERDETEKSI${R}"
log "ROOT OK"
}

check_mount() {
echo -e "${Y}[*] Mengecek system mount...${R}"
MNT=$(mount | grep ' /system ')
echo " Status awal: $MNT"
}

mount_rw() {
echo -e "${Y}[*] Mengubah system menjadi RW...${R}"
su -c "mount -o remount,rw /system" 2>/dev/null
}

auto_test() {
[ "$TEST_MODE" != "1" ] && return
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║            AUTO TEST RW             ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

TEST_FILE="/system/root_ragers_test.txt"
su -c "echo 'test' > $TEST_FILE" 2>/dev/null

if [ -f "$TEST_FILE" ]; then
  echo -e "${G}[✓] MOUNT RW SUCCESS — WRITE OK${R}"
  log "MOUNT RW SUCCESS"
  su -c "rm $TEST_FILE" 2>/dev/null
else
  echo -e "${RED}[✗] MOUNT RW FAILED — WRITE GAGAL${R}"
  log "MOUNT RW FAILED"
fi
}

main() {
header
check_root
progress
check_mount
mount_rw
progress
check_mount
auto_test
pause
}

main
