#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# KERNEL INFO MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="KERNEL INFO"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║           KERNEL INFO MODULE         ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
}

progress_bar() {
    local text="$1"
    echo -ne "${Y}$text"
    for i in $(seq 1 40); do
        echo -ne "."
        sleep 0.05
    done
    echo -e "${R}"
}

check_root() {
    if command -v su >/dev/null 2>&1; then
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa akses info kernel penuh${R}"
        log "ROOT OK"
    else
        echo -e "${Y}[!] ROOT TIDAK TERDETEKSI — Info kernel terbatas${R}"
        log "ROOT NOT DETECTED"
    fi
}

show_kernel_info() {
    echo -e "${Y}[*] Menampilkan informasi kernel...${R}"
    echo "-----------------------------------------"
    echo -e "${G}Kernel Name: $(uname -s)${R}"
    echo -e "${G}Kernel Version: $(uname -r)${R}"
    echo -e "${G}Kernel Build: $(uname -v)${R}"
    echo -e "${G}Machine: $(uname -m)${R}"
    echo -e "${G}CPU Info: $(grep 'model name' /proc/cpuinfo | uniq | awk -F: '{print $2}' | sed 's/^ *//')${R}"
    echo "-----------------------------------------"
    log "Kernel info displayed"
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║           AUTO TEST KERNEL           ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    if [ -r /proc/version ]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — Kernel info dapat dibaca${R}"
        log "AUTO TEST OK: /proc/version readable"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — Kernel info tidak bisa dibaca${R}"
        log "AUTO TEST FAILED: /proc/version unreadable"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Mengambil Info Kernel"
    show_kernel_info
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
