#!/data/data/com.termux/files/usr/bin/bash

R="\e[0m"; G="\e[1;32m"; C="\e[1;36m"; M="\e[1;35m"

clear
for i in {1..15}; do
  echo -e "${G}$(tr -dc '01█▓▒░' </dev/urandom | head -c 70)${R}"
  sleep 0.05
done

echo -e "${C}"
echo "MIKROTIK SECURE ACCESS GRANTED"
echo "Launching Control Center..."
sleep 1

bash modules/mikrotik_control.sh
