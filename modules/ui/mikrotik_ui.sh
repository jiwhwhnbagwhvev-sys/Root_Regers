#!/data/data/com.termux/files/usr/bin/bash
# =====================================================
# MIKROTIK CONTROL UI — ROOT_REGERS
# Advanced Terminal Dashboard
# =====================================================

R="\e[0m"
G="\e[1;32m"
Y="\e[1;33m"
RED="\e[1;31m"
C="\e[1;36m"
B="\e[1m"
P="\e[1;35m"

CONF="devices.conf"

banner() {
clear
echo -e "${C}${B}"
echo "╔════════════════════════════════════════════════════╗"
echo "║              M I K R O T I K  P A N E L             ║"
echo "║        Advanced Network Control Dashboard           ║"
echo "╠════════════════════════════════════════════════════╣"
echo "║ Status : ONLINE                                    ║"
echo "║ Mode   : ADMIN TERMINAL                            ║"
echo "╚════════════════════════════════════════════════════╝"
echo -e "${R}"
}

loading() {
echo -ne "${Y}Initializing"
for i in {1..30}; do
  echo -ne "."
  sleep 0.04
done
echo -e "${R}"
}

check_dep() {
for bin in ssh awk sed grep; do
  command -v $bin >/dev/null || {
    echo -e "${RED}[✗] Dependency missing: $bin${R}"
    exit 1
  }
done
}

load_device() {
if [ ! -f "$CONF" ]; then
  echo -e "${RED}[!] devices.conf tidak ditemukan${R}"
  echo "Contoh isi:"
  echo "192.168.88.1|admin|password"
  exit 1
fi

IP=$(cut -d'|' -f1 "$CONF")
USER=$(cut -d'|' -f2 "$CONF")
PASS=$(cut -d'|' -f3 "$CONF")
}

ssh_exec() {
sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $USER@$IP "$1"
}

status_panel() {
echo -e "${P}${B}── Router Status ─────────────────────────${R}"
ssh_exec "system resource print"
}

interface_panel() {
echo -e "${P}${B}── Interfaces ────────────────────────────${R}"
ssh_exec "interface print"
}

dhcp_panel() {
echo -e "${P}${B}── DHCP Leases (Connected Devices) ───────${R}"
ssh_exec "ip dhcp-server lease print"
}

firewall_panel() {
echo -e "${P}${B}── Firewall Rules ─────────────────────────${R}"
ssh_exec "ip firewall filter print"
}

reboot_router() {
echo -e "${RED}[!] Router akan reboot${R}"
ssh_exec "system reboot"
}

menu() {
echo
echo -e "${C}1) Router Status"
echo "2) Interface Monitor"
echo "3) DHCP Client List"
echo "4) Firewall Rules"
echo "5) Reboot Router"
echo "0) Exit Panel${R}"
echo
read -rp "Select > " ch
}

main() {
banner
check_dep
loading
load_device

while true; do
  banner
  menu
  case $ch in
    1) status_panel; read -rp "ENTER..." ;;
    2) interface_panel; read -rp "ENTER..." ;;
    3) dhcp_panel; read -rp "ENTER..." ;;
    4) firewall_panel; read -rp "ENTER..." ;;
    5) reboot_router; exit ;;
    0) exit ;;
    *) echo -e "${RED}Invalid option${R}"; sleep 1 ;;
  esac
done
}

main
