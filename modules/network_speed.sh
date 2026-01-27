#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# NETWORK SPEED & IP CHECK — ROOT_RAGERS
# ==========================================

MODULE_NAME="NETWORK SPEED CHECK"
LOG="/data/local/tmp/root_ragers.log"

R="\e[0m"
G="\e[1;32m"
Y="\e[1;33m"
RED="\e[1;31m"
C="\e[1;36m"
B="\e[1m"

pause() {
  echo
  read -rp "Tekan ENTER untuk kembali ke menu..."
}

log() {
  echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"
}

header() {
  clear
  echo -e "${C}${B}"
  echo "╔══════════════════════════════════════╗"
  echo "║        NETWORK SPEED CHECK           ║"
  echo "╚══════════════════════════════════════╝"
  echo -e "${R}"
}

progress() {
  echo -ne "${Y}Memproses"
  for i in $(seq 1 35); do
    echo -ne "."
    sleep 0.05
  done
  echo -e "${R}"
}

check_dep() {
  if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}[✗] curl belum terinstall${R}"
    echo "Install dengan: pkg install curl"
    exit 1
  fi
}

check_ip() {
  echo -e "${Y}[*] Mengambil IP Address...${R}"

  LOCAL_IP=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7}')
  PUBLIC_IP=$(curl -s https://ifconfig.me)

  echo -e "${G}[✓] IP Lokal  : ${B}${LOCAL_IP:-Tidak terdeteksi}${R}"
  echo -e "${G}[✓] IP Publik : ${B}${PUBLIC_IP:-Tidak terdeteksi}${R}"

  log "Local IP: $LOCAL_IP | Public IP: $PUBLIC_IP"
}

check_ping() {
  echo
  echo -e "${Y}[*] Menguji PING ke Google (8.8.8.8)...${R}"
  PING_RESULT=$(ping -c 4 8.8.8.8 | tail -1)

  if echo "$PING_RESULT" | grep -q "min"; then
    echo -e "${G}[✓] Ping OK${R}"
    echo -e "${C}$PING_RESULT${R}"
    log "Ping OK: $PING_RESULT"
  else
    echo -e "${RED}[✗] Ping gagal${R}"
    log "Ping FAILED"
  fi
}

speed_test() {
  echo
  echo -e "${Y}[*] Menguji kecepatan download (Cloudflare)...${R}"
  progress

  START=$(date +%s)
  curl -o /data/local/tmp/speed_test.tmp https://speed.cloudflare.com/__down?bytes=25000000 >/dev/null 2>&1
  END=$(date +%s)

  if [ -f /data/local/tmp/speed_test.tmp ]; then
    SIZE_MB=25
    TIME=$((END - START))
    SPEED=$((SIZE_MB / TIME))

    echo -e "${G}[✓] Download Speed : ${B}${SPEED} MB/s${R}"
    log "Speed Test: ${SPEED} MB/s"
    rm -f /data/local/tmp/speed_test.tmp
  else
    echo -e "${RED}[✗] Speed test gagal${R}"
    log "Speed Test FAILED"
  fi
}

auto_test() {
  echo
  echo -e "${C}${B}"
  echo "╔══════════════════════════════════════╗"
  echo "║        AUTO TEST NETWORK             ║"
  echo "╚══════════════════════════════════════╝"
  echo -e "${R}"

  if ping -c 1 1.1.1.1 >/dev/null 2>&1; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — Network stabil${R}"
    log "AUTO TEST OK"
  else
    echo -e "${RED}[✗] AUTO TEST FAILED — Network bermasalah${R}"
    log "AUTO TEST FAILED"
  fi
}

main() {
  header
  check_dep
  check_ip
  progress
  check_ping
  progress
  speed_test
  auto_test
  pause
}

main
