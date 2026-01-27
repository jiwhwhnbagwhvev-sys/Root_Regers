#!/data/data/com.termux/files/usr/bin/bash
# ==================================================
# LED BLE CONTROL CENTER — ROOT_RAGERS
# ==================================================

R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"
C="\e[1;36m"; M="\e[1;35m"; B="\e[1m"; RED="\e[1;31m"

header(){
clear
echo -e "${M}${B}"
echo "╔══════════════════════════════════════╗"
echo "║        LED BLE CONTROL CENTER        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${C}Target: LED Ble 00-XXXX${R}\n"
}

hacker_ui(){
for i in {1..10}; do
  echo -e "${M}Scanning BLE spectrum [$((RANDOM%90+10))%]${R}"
  sleep 0.15
  clear
done
}

scan_ble(){
header
hacker_ui
echo -e "${Y}[*] Memindai perangkat BLE (via sistem)...${R}\n"

if ! command -v termux-bluetooth-scan >/dev/null 2>&1; then
  echo -e "${RED}[✗] termux-api belum terinstall${R}"
  echo -e "${Y}Install: pkg install termux-api${R}"
  exit 1
fi

termux-bluetooth-scan | grep -i "LED Ble" || {
  echo -e "${RED}[!] LED BLE tidak terdeteksi${R}"
}
}

menu(){
echo
echo -e "${C}PILIH AKSI:${R}"
echo "1. Scan LED BLE"
echo "2. Buka nRF Connect (kontrol manual)"
echo "3. Info cara pairing"
echo "0. Kembali"
read -rp "Pilih: " p
}

open_nrf(){
echo -e "${G}[✓] Membuka nRF Connect...${R}"
am start -n no.nordicsemi.android.mcp/.MainActivity >/dev/null 2>&1
}

info(){
echo -e "${Y}"
echo "CARA KONTROL LED:"
echo "1. Buka nRF Connect"
echo "2. Connect ke LED Ble 00-XXXX"
echo "3. Cari service 0xFFE0 / 0xFFF0"
echo "4. Ubah warna via characteristic write"
echo
echo "Catatan:"
echo "- Ini batas Android, bukan script"
echo "- Cara ini REAL & dipakai engineer"
echo -e "${R}"
read -rp "ENTER..."
}

main(){
while true; do
  header
  menu
  case $p in
    1) scan_ble; read -rp "ENTER..." ;;
    2) open_nrf ;;
    3) info ;;
    0) break ;;
    *) echo "Salah"; sleep 1 ;;
  esac
done
}

main
