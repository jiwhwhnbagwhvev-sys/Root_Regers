    #!/data/data/com.termux/files/usr/bin/bash

# ===== WARNA =====
RED="\e[31m"
GRN="\e[32m"
YLW="\e[33m"
BLU="\e[34m"
CYN="\e[36m"
MAG="\e[35m"
WHT="\e[97m"
B="\e[1m"
R="\e[0m"

clear

# ===== LOGO =====
echo -e "${CYN}${B}
╔══════════════════════════════════════╗
║   ██████╗  ██████╗  ██████╗         ║
║   ██╔══██╗██╔═══██╗██╔═══██╗        ║
║   ██████╔╝██║   ██║██║   ██║        ║
║   ██╔══██╗██║   ██║██║   ██║        ║
║   ██║  ██║╚██████╔╝╚██████╔╝        ║
║   ╚═╝  ╚═╝ ╚═════╝  ╚═════╝         ║
║        ROOT  RAGERS  2026 ☠          ║
╚══════════════════════════════════════╝
${R}"

# ===== AKUN =====
USERNAME="Rio2026"
PASSWORD="Root_Rage 2026"

echo
read -p " Username : " U
read -s -p " Password : " P
echo
echo

# ===== VALIDASI =====
if [[ "$U" == "$USERNAME" && "$P" == "$PASSWORD" ]]; then
  echo -e "${GRN}[✓] LOGIN SUCCESS — WELCOME $USERNAME${R}"
  echo
  echo -ne "${YLW}Loading${R} "

  # ===== LOADING WARNA-WARNI =====
  for i in {1..30}; do
    COLORS=($RED $GRN $YLW $BLU $MAG $CYN)
    C=${COLORS[$RANDOM % 6]}
    printf "${C}█${R}"
    sleep 0.04
  done

  sleep 0.6
  clear
else
  echo -e "${RED}[✗] LOGIN FAILED${R}"
  sleep 1.5
  exit 1
fi
