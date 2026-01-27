#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# NETWORK BOOST MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="NETWORK BOOST"
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
echo "║          NETWORK BOOST MODULE        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

progress() {
echo -ne "${Y}Mengoptimalkan jaringan"
for i in $(seq 1 40); do
  echo -ne "."
  sleep 0.05
done
echo -e "${R}"
}

check_root() {
if ! command -v su >/dev/null 2>&1; then
  echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Mode simulasi${R}"
  log "ROOT NOT DETECTED"
else
  echo -e "${G}[✓] ROOT TERDETEKSI${R}"
  log "ROOT OK"
fi
}

network_boost() {
echo -e "${Y}[*] Menerapkan optimasi jaringan...${R}"
sleep 0.3

if command -v su >/dev/null 2>&1; then
    # Ubah DNS sementara jika root
    echo "[✓] Mengatur DNS ke 1.1.1.1 / 8.8.8.8"
    su -c "setprop net.dns1 1.1.1.1"
    su -c "setprop net.dns2 8.8.8.8"

    # Optimasi MTU
    echo "[✓] Mengoptimalkan MTU paket..."
    su -c "ifconfig wlan0 mtu 1500" 2>/dev/null || echo "[!] Gagal ubah MTU"
else
    echo "[!] ROOT TIDAK TERDETEKSI — Hanya simulasi optimasi"
fi
sleep 0.5
}

auto_test() {
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║            AUTO TEST NETWORK         ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"

echo "[*] Ping test ke Google (8.8.8.8)..."
ping -c 4 8.8.8.8
if [ $? -eq 0 ]; then
    echo -e "${G}[✓] AUTO TEST SUCCESS — Koneksi OK${R}"
    log "Network ping test OK"
else
    echo -e "${RED}[✗] AUTO TEST FAILED — Tidak ada koneksi${R}"
    log "Network ping test FAILED"
fi
sleep 0.5
}

main() {
header
check_root
progress
network_boost
progress
auto_test
pause
}

main
