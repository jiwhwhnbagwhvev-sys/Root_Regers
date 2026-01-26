#!/data/data/com.termux/files/usr/bin/bash

# ===== WARNA =====
RED="\033[31m"
GRN="\033[32m"
YLW="\033[33m"
BLU="\033[34m"
MAG="\033[35m"
CYN="\033[36m"
WHT="\033[97m"
BOLD="\033[1m"
RST="\033[0m"

USER_OK="Rio"
PASS_OK="Root_Rage 2026"

clear

# ===== LOGO WARNA-WARNI =====
logo() {
clear
cat <<EOF
${RED}██████╗ ${GRN}██████╗ ${YLW}██████╗ ${BLU}████████╗
${MAG}██╔══██╗${CYN}██╔═══██╗${RED}██╔═══██╗${GRN}╚══██╔══╝
${YLW}██████╔╝${BLU}██║   ██║${MAG}██║   ██║${CYN}   ██║
${RED}██╔══██╗${GRN}██║   ██║${YLW}██║   ██║${BLU}   ██║
${MAG}██║  ██║${CYN}╚██████╔╝${RED}╚██████╔╝${GRN}   ██║
${YLW}╚═╝  ╚═╝${BLU} ╚═════╝ ${MAG} ╚═════╝ ${CYN}   ╚═╝
${WHT}${BOLD}        ROOT  RAGERS  2026${RST}
EOF
}

logo
sleep 0.5

# ===== LOADING ANIMASI =====
echo
echo -ne "${CYN}Initializing System "
spin='|/-\'
for i in {1..20}; do
  printf "\b${spin:i%4:1}"
  sleep 0.1
done
echo -e " ${GRN}[OK]${RST}"
sleep 0.5
clear
logo

# ===== PANEL LOGIN =====
echo
echo -e "${WHT}+--------------------------------------+${RST}"
echo -e "${WHT}|${RED}        AUTHENTICATION PANEL        ${WHT}|${RST}"
echo -e "${WHT}+---------------+----------------------+${RST}"
echo -e "${WHT}|${RED} User          ${WHT}| Rio                  ${WHT}|${RST}"
echo -e "${WHT}|${RED} Access        ${WHT}| ROOT MODE            ${WHT}|${RST}"
echo -e "${WHT}+---------------+----------------------+${RST}"
echo

# ===== INPUT =====
read -p "$(echo -e ${MAG}${BOLD}Username${RST}': ')" user
read -s -p "$(echo -e ${MAG}${BOLD}Password${RST}': ')" pass
echo
echo

# ===== VALIDASI =====
if [[ "$user" == "$USER_OK" && "$pass" == "$PASS_OK" ]]; then
    echo -e "${GRN}${BOLD}[✓] LOGIN SUCCESS${RST}"
    echo -ne "${CYN}Access Granted "
    for i in {1..10}; do
      echo -ne "${GRN}■${RST}"
      sleep 0.1
    done
    sleep 0.5
else
    echo -e "${RED}${BOLD}[✗] LOGIN FAILED${RST}"
    sleep 2
    exit 1
fi
