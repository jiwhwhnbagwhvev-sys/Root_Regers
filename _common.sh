#!/data/data/com.termux/files/usr/bin/bash

# Fungsi kembali ke menu
back() {
  echo
  read -p "Tekan Enter untuk kembali ke menu, q untuk keluar: " c
  [[ "$c" =~ ^[qQ]$ ]] && exit || return
}

# Cek root / tsu
need_root() {
  command -v tsu >/dev/null 2>&1 || { echo "[!] tsu tidak ditemukan"; back; }
}

# Animasi loading
loading() {
  for i in {1..3}; do
    echo -ne "."
    sleep 0.5
  done
  echo
}
