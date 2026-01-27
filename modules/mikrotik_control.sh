#!/data/data/com.termux/files/usr/bin/bash
# ==================================================
# MIKROTIK CONTROL CENTER — ROOT_RAGERS
# ==================================================

BASE="$HOME/Root_Regers"
DATA="$BASE/data/mikrotik"
CONF="$DATA/devices.conf"
LOG="$DATA/logs.txt"

R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"
C="\e[1;36m"; RED="\e[1;31m"; B="\e[1m"

mkdir -p "$DATA/backups"

pause(){ read -rp "ENTER untuk lanjut..."; }

header(){
clear
echo -e "${C}${B}"
echo "╔══════════════════════════════════════╗"
echo "║      MIKROTIK CONTROL CENTER         ║"
echo "╚══════════════════════════════════════╝"
echo -e "${R}"
}

check_dep(){
if ! command -v ssh >/dev/null; then
  echo -e "${RED}[✗] SSH belum terinstall${R}"
  echo "pkg install openssh"
  exit 1
fi
}

load_device(){
if [ ! -f "$CONF" ]; then
  echo -e "${Y}[!] devices.conf belum ada${R}"
  echo "Format: user@ip:port"
  echo "Contoh: admin@192.168.88.1:22"
  pause
  exit 1
fi
DEVICE=$(head -n1 "$CONF")
USER=$(echo "$DEVICE" | cut -d@ -f1)
IP=$(echo "$DEVICE" | cut -d@ -f2 | cut -d: -f1)
PORT=$(echo "$DEVICE" | cut -d: -f2)
}

exec_mt(){
ssh -p "$PORT" "$USER@$IP" "$1"
echo "[$(date)] $1" >> "$LOG"
}

status(){
echo -e "${Y}[*] Status MikroTik${R}"
exec_mt "/system resource print"
pause
}

interfaces(){
echo -e "${Y}[*] Interface List${R}"
exec_mt "/interface print"
pause
}

dhcp(){
echo -e "${Y}[*] DHCP Clients${R}"
exec_mt "/ip dhcp-server lease print"
pause
}

hotspot(){
echo -e "${Y}[*] Hotspot Active Users${R}"
exec_mt "/ip hotspot active print"
pause
}

backup(){
NAME="backup_$(date +%F_%H%M)"
exec_mt "/system backup save name=$NAME"
echo -e "${G}[✓] Backup dibuat: $NAME${R}"
pause
}

reboot_mt(){
read -rp "Reboot MikroTik? (y/n): " x
[ "$x" = "y" ] && exec_mt "/system reboot"
}

menu(){
header
echo "1. Status Router"
echo "2. Interface Monitor"
echo "3. DHCP Clients"
echo "4. Hotspot Users"
echo "5. Backup Config"
echo "6. Reboot Router"
echo "0. Kembali"
read -rp "Pilih: " p
}

main(){
check_dep
load_device
while true; do
  menu
  case $p in
    1) status ;;
    2) interfaces ;;
    3) dhcp ;;
    4) hotspot ;;
    5) backup ;;
    6) reboot_mt ;;
    0) break ;;
  esac
done
}

main
