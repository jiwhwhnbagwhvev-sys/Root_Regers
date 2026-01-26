#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# BACKUP APPS MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="BACKUP APPS"
LOG="/data/local/tmp/root_ragers.log"
BACKUP_DIR="/data/local/tmp/app_backups"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║            BACKUP APPS MODULE        ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa backup apps system${R}"
        log "ROOT OK"
    else
        echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — Backup terbatas${R}"
        log "ROOT NOT DETECTED"
        pause
        exit 1
    fi
}

prepare_backup_dir() {
    echo -e "${Y}[*] Membuat folder backup: $BACKUP_DIR${R}"
    su -c "mkdir -p $BACKUP_DIR"
    log "Backup directory prepared"
}

backup_apps() {
    echo -e "${Y}[*] Memulai backup aplikasi user...${R}"
    sleep 0.3

    # Loop semua folder APK user
    USER_APPS="/data/app"
    for APP_DIR in "$USER_APPS"/*; do
        APP_NAME=$(basename "$APP_DIR")
        DEST="$BACKUP_DIR/$APP_NAME"
        su -c "cp -r $APP_DIR $DEST" >/dev/null 2>&1
        log "Backup $APP_NAME done"
    done

    echo -e "${G}[✓] Backup semua aplikasi selesai${R}"
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          AUTO TEST BACKUP            ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR)" ]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — Backup apps berhasil${R}"
        log "AUTO TEST OK: Backup directory populated"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — Backup apps kosong${R}"
        log "AUTO TEST FAILED: Backup directory empty"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Menyiapkan Backup Folder"
    prepare_backup_dir
    progress_bar "Memulai Backup Apps"
    backup_apps
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
