#!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# BATTERY SAVER MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="BATTERY SAVER"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║           BATTERY SAVER MODULE       ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa tweak battery${R}"
        log "ROOT OK"
    else
        echo -e "${Y}[!] ROOT TIDAK TERDETEKSI — Battery saver terbatas${R}"
        log "ROOT NOT DETECTED"
    fi
}

optimize_battery() {
    echo -e "${Y}[*] Menonaktifkan wakelock dan background services...${R}"
    sleep 0.3

    # Contoh tweak: hentikan beberapa service intensif (simulasi)
    SERVICES=("com.android.sync" "com.google.android.gms" "com.android.updater")
    for S in "${SERVICES[@]}"; do
        su -c "am stopservice $S" >/dev/null 2>&1
        log "Service $S dihentikan"
    done

    # Matikan beberapa animasi (simulasi)
    su -c "settings put global window_animation_scale 0.0" >/dev/null 2>&1
    su -c "settings put global transition_animation_scale 0.0" >/dev/null 2>&1
    su -c "settings put global animator_duration_scale 0.0" >/dev/null 2>&1
    log "Animation scale dimatikan"

    echo -e "${G}[✓] Optimasi Battery selesai${R}"
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          AUTO TEST BATTERY           ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    # Cek animation scale
    WIN=$(su -c "settings get global window_animation_scale")
    TRANS=$(su -c "settings get global transition_animation_scale")
    ANIM=$(su -c "settings get global animator_duration_scale")

    if [[ "$WIN" == "0.0" && "$TRANS" == "0.0" && "$ANIM" == "0.0" ]]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — Animation scale dimatikan${R}"
        log "AUTO TEST OK: Animation scales set to 0.0"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — Animation scale tidak berubah${R}"
        log "AUTO TEST FAILED: Animation scales not set"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Menjalankan Optimasi Battery"
    optimize_battery
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
