#!/data/data/com.termux/files/usr/bin/bash
# DARK CODING LAB MODULE

ENGINE="engine/dark_coding_lab_engine.py"

clear
echo -e "\e[1;31m"
echo "╔════════════════════════════════════╗"
echo "║        DARK CODING LAB MODULE      ║"
echo "╚════════════════════════════════════╝"
echo -e "\e[0m"

if ! command -v python >/dev/null; then
  echo "[*] Install python..."
  pkg install python -y
fi

if [ ! -f "$ENGINE" ]; then
  echo "[!] Engine tidak ditemukan!"
  read -rp "ENTER..."
  exit 1
fi

python "$ENGINE"
read -rp "ENTER untuk kembali..."
