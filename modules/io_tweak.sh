#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# IO TWEAK MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="IO TWEAK"
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
echo "║            IO TWEAK MODULE           ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Mengoptimasi I/O"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI${R}"
  log "ROOT NOT DETECTED"
  exit 1
fi
echo -e "${G}[✓] ROOT TERDETEKSI${R}"
log "ROOT OK"
}

io_tweak() {
echo -e "${Y}[*] Menetapkan scheduler dan cache untuk I/O...${R}"

# Set scheduler ke 'deadline' untuk semua mmc block devices
for DEV in /sys/block/mmcblk*; do
  if [ -f "$DEV/queue/scheduler" ]; then
    su -c "echo deadline > $DEV/queue/scheduler"
    log "Set scheduler deadline -> $DEV"
  fi
done

# Set read-ahead buffer
for DEV in /sys/block/mmcblk*/queue/read_ahead_kb; do
  su -c "echo 512 > $DEV"
  log "Set read_ahead_kb 512 -> $DEV"
done

# Enable write cache
for DEV in /sys/block/mmcblk*/queue/write_cache; do
  if [ -f "$DEV" ]; then
    su -c "echo writeback > $DEV"
    log "Set write_cache writeback -> $DEV"
  fi
done

echo -e "${G}[✓] I/O Tweaks diterapkan${R}"
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║             AUTO TEST IO             ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

# Test read/write sederhana ke /data
TEST_FILE="/data/local/tmp/io_test.tmp"
dd if=/dev/zero of="$TEST_FILE" bs=1M count=5 >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo -e "${G}[✓] AUTO TEST SUCCESS — I/O write OK${R}"
  log "I/O write test OK"
else
  echo -e "${RED}[✗] AUTO TEST FAILED — I/O write gagal${R}"
  log "I/O write test FAILED"
fi
rm -f "$TEST_FILE"
}

main() {
header
check_root
progress
io_tweak
progress
auto_test
pause
}

main
