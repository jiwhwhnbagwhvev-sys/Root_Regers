  #!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# DISABLE THERMAL MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="DISABLE THERMAL"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          DISABLE THERMAL MODULE      ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa menonaktifkan thermal${R}"
        log "ROOT OK"
    else
        echo -e "${RED}[✗] ROOT TIDAK TERDEKSI — Tidak bisa disable thermal${R}"
        log "ROOT NOT DETECTED"
        pause
        exit 1
    fi
}

disable_thermal() {
    echo -e "${Y}[*] Menonaktifkan thermal throttling...${R}"
    sleep 0.3

    THERMAL_PATH="/sys/module/msm_thermal/core_control/enabled"
    if [ -f "$THERMAL_PATH" ]; then
        su -c "echo 0 > $THERMAL_PATH"
        echo -e "${G}[✓] Thermal throttling dinonaktifkan${R}"
        log "Thermal throttling disabled"
    else
        echo -e "${RED}[✗] Thermal path tidak ditemukan${R}"
        log "Thermal path missing"
    fi
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          AUTO TEST THERMAL OFF       ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    TEST_FILE="/sys/module/msm_thermal/core_control/enabled"
    if [ -f "$TEST_FILE" ] && [ "$(su -c "cat $TEST_FILE")" == "0" ]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — Thermal off aktif${R}"
        log "AUTO TEST OK: Thermal disabled"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — Thermal off tidak aktif${R}"
        log "AUTO TEST FAILED: Thermal not disabled"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Menonaktifkan Thermal"
    disable_thermal
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
