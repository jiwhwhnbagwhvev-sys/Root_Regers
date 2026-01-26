#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# RAM CLEANER MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="RAM CLEANER"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║           RAM CLEANER MODULE         ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa membersihkan RAM${R}"
        log "ROOT OK"
    else
        echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — RAM cleanup terbatas${R}"
        log "ROOT NOT DETECTED"
        pause
        exit 1
    fi
}

ram_clean() {
    echo -e "${Y}[*] Membersihkan RAM...${R}"
    sleep 0.3

    # Sinkronisasi filesystem & drop caches
    su -c "sync"
    su -c "echo 3 > /proc/sys/vm/drop_caches"
    log "RAM cache dropped"

    # Optional: tunjukan penggunaan RAM sebelum & sesudah
    echo -e "${G}[✓] RAM berhasil dibersihkan${R}"
    free -h | awk 'NR==2{printf "[*] RAM Usage: %s/%s\n", $3,$2}'
    log "RAM usage displayed"
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          AUTO TEST RAM CLEANER       ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    TEST_FILE="/proc/sys/vm/drop_caches"
    if [ -w "$TEST_FILE" ]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — RAM cleaner dapat dijalankan${R}"
        log "AUTO TEST OK: drop_caches writable"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — RAM cleaner gagal${R}"
        log "AUTO TEST FAILED: drop_caches not writable"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Membersihkan RAM"
    ram_clean
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
