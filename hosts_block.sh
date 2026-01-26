#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# HOSTS BLOCK MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="HOSTS BLOCK"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          HOSTS BLOCK MODULE          ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa modifikasi /etc/hosts${R}"
        log "ROOT OK"
    else
        echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Modifikasi hosts gagal${R}"
        log "ROOT NOT DETECTED"
        pause
        exit 1
    fi
}

block_hosts() {
    HOSTS_FILE="/etc/hosts"
    BACKUP_FILE="/data/local/tmp/hosts_backup_$(date +%F_%T).bak"

    echo -e "${Y}[*] Membuat backup hosts...${R}"
    su -c "cp $HOSTS_FILE $BACKUP_FILE"
    if [ $? -eq 0 ]; then
        echo -e "${G}[✓] Backup hosts tersimpan di $BACKUP_FILE${R}"
        log "Hosts backup OK"
    else
        echo -e "${RED}[✗] Gagal membuat backup hosts${R}"
        log "Hosts backup FAILED"
    fi
    sleep 0.3

    echo -e "${Y}[*] Menambahkan entri adblock...${R}"
    # Contoh: blokir iklan umum
    su -c "echo '127.0.0.1 ad.doubleclick.net' >> $HOSTS_FILE"
    su -c "echo '127.0.0.1 pagead2.googlesyndication.com' >> $HOSTS_FILE"
    su -c "echo '127.0.0.1 googleadservices.com' >> $HOSTS_FILE"
    su -c "echo '127.0.0.1 partner.googleadservices.com' >> $HOSTS_FILE"

    echo -e "${G}[✓] Hosts berhasil diupdate untuk adblock${R}"
    log "Hosts updated for adblock"
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║         AUTO TEST HOSTS BLOCK        ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    TEST_ENTRY="127.0.0.1 ad.doubleclick.net"
    if su -c "grep -q '$TEST_ENTRY' /etc/hosts"; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — Hosts entry ada${R}"
        log "AUTO TEST OK: hosts entry found"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — Hosts entry tidak ada${R}"
        log "AUTO TEST FAILED: hosts entry missing"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Memproses Hosts Block"
    block_hosts
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
