#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# MOUNT RW MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="MOUNT RW"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║             MOUNT RW MODULE          ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa mount RW${R}"
        log "ROOT OK"
    else
        echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Mount RW gagal${R}"
        log "ROOT NOT DETECTED"
        pause
        exit 1
    fi
}

mount_rw() {
    echo -e "${Y}[*] Mengubah /system & /data menjadi RW...${R}"
    sleep 0.3

    for PART in /system /data; do
        if mount | grep -q "$PART"; then
            su -c "mount -o rw,remount $PART"
            if [ $? -eq 0 ]; then
                echo -e "${G}[✓] $PART berhasil di mount RW${R}"
                log "$PART mounted RW"
            else
                echo -e "${RED}[✗] Gagal mount $PART${R}"
                log "FAILED mounting $PART"
            fi
        else
            echo -e "${Y}[!] $PART tidak ditemukan${R}"
            log "$PART not found"
        fi
        sleep 0.3
    done
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║           AUTO TEST MOUNT RW         ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    TEST_FILE="/system/test_rw.tmp"
    su -c "echo 'test' > $TEST_FILE" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — /system RW OK${R}"
        log "AUTO TEST OK: /system writable"
        su -c "rm -f $TEST_FILE"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — /system tidak RW${R}"
        log "AUTO TEST FAILED: /system not writable"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Mengubah mount menjadi RW"
    mount_rw
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
