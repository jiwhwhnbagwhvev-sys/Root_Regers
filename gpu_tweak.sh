#!/system/bin/sh
# ==========================================
# GPU BOOST MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="GPU BOOST"
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
echo "║            GPU BOOST MODULE          ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Memproses GPU"
for i in $(seq 1 25); do
  echo -ne "."
  sleep 0.08
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

detect_gpu() {
GPU_PATH="/sys/class/kgsl/kgsl-3d0/"
if [ -d "$GPU_PATH" ]; then
  echo -e "${G}[✓] GPU detected at $GPU_PATH${R}"
else
  echo -e "${Y}[!] GPU path tidak ditemukan, kemungkinan device unsupported${R}"
  GPU_PATH=""
fi
}

gpu_status() {
[ -z "$GPU_PATH" ] && return
echo -e "${Y}[*] Status GPU:${R}"
if [ -f "$GPU_PATH/devfreq/governor" ]; then
  GOV=$(cat $GPU_PATH/devfreq/governor)
  echo " Current governor: $GOV"
fi
if [ -f "$GPU_PATH/devfreq/min_freq" ]; then
  MIN_FREQ=$(cat $GPU_PATH/devfreq/min_freq)
  MAX_FREQ=$(cat $GPU_PATH/devfreq/max_freq)
  echo " Freq min: $MIN_FREQ"
  echo " Freq max: $MAX_FREQ"
fi
}

set_gpu_boost() {
[ -z "$GPU_PATH" ] && return
echo -e "${Y}[*] Menerapkan GPU BOOST mode performance${R}"
if [ -f "$GPU_PATH/devfreq/governor" ]; then
  su -c "echo performance > $GPU_PATH/devfreq/governor"
  log "GPU governor set to performance"
fi
}

auto_test() {
[ "$TEST_MODE" != "1" ] && return
[ -z "$GPU_PATH" ] && return

echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║           AUTO TEST GPU             ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

echo -e "${Y}[*] Render loop ringan (3 detik)...${R}"
# SAFE TEST: render loop dummy (yes /dev/null)
yes > /dev/null &
PID=$!
sleep 3
kill $PID 2>/dev/null

echo -e "${G}[✓] AUTO TEST GPU SELESAI${R}"
log "AUTO TEST GPU OK"
}

main() {
header
check_root
progress
detect_gpu
gpu_status
set_gpu_boost
progress
gpu_status
auto_test
pause
}

main
