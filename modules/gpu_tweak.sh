  #!/data/data/com.termux/files/usr/bin/bash
# ==========================================
# GPU BOOST MODULE — ROOT_RAGERS
# ==========================================

MODULE_NAME="GPU BOOST"
LOG="/data/local/tmp/root_ragers.log"
R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"; C="\e[1;36m"; B="\e[1m"

pause() { read -rp "Tekan ENTER untuk kembali ke menu..."; }
log() { echo "[$(date '+%F %T')] $MODULE_NAME : $1" >> "$LOG"; }

header() {
    clear
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║           GPU BOOST MODULE           ║"
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
        echo -e "${G}[✓] ROOT TERDETEKSI — Bisa tweak GPU${R}"
        log "ROOT OK"
    else
        echo -e "${RED}[✗] ROOT TIDAK TERDETEKSI — GPU tweak gagal${R}"
        log "ROOT NOT DETECTED"
        pause
        exit 1
    fi
}

gpu_boost() {
    echo -e "${Y}[*] Mengatur GPU governor dan frekuensi maksimal...${R}"
    sleep 0.3

    GPU_PATH="/sys/class/kgsl/kgsl-3d0"

    if [ -d "$GPU_PATH" ]; then
        GOVERNOR_FILE="$GPU_PATH/devfreq/governor"
        MAX_FREQ_FILE="$GPU_PATH/devfreq/max_freq"

        if [ -f "$GOVERNOR_FILE" ] && [ -f "$MAX_FREQ_FILE" ]; then
            su -c "echo performance > $GOVERNOR_FILE"
            MAX_FREQ=$(su -c "cat $MAX_FREQ_FILE")
            su -c "echo $MAX_FREQ > $MAX_FREQ_FILE"
            echo -e "${G}[✓] GPU dioptimalkan${R}"
            log "GPU optimized: governor set to performance, max freq applied"
        else
            echo -e "${RED}[✗] File GPU tidak ditemukan${R}"
            log "GPU files not found"
        fi
    else
        echo -e "${RED}[✗] GPU path tidak tersedia${R}"
        log "GPU path missing"
    fi
}

auto_test() {
    echo -e "${C}${B}"
    echo "╔══════════════════════════════════════╗"
    echo "║          AUTO TEST GPU BOOST         ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${R}"
    sleep 0.3

    TEST_FILE="/sys/class/kgsl/kgsl-3d0/devfreq/governor"
    if [ -f "$TEST_FILE" ] && [ "$(su -c "cat $TEST_FILE")" == "performance" ]; then
        echo -e "${G}[✓] AUTO TEST SUCCESS — GPU governor performance aktif${R}"
        log "AUTO TEST OK: GPU governor set to performance"
    else
        echo -e "${RED}[✗] AUTO TEST FAILED — GPU governor tidak diubah${R}"
        log "AUTO TEST FAILED: GPU governor not applied"
    fi
    sleep 0.3
}

main() {
    header
    check_root
    progress_bar "Mengoptimalkan GPU"
    gpu_boost
    progress_bar "Menjalankan Auto Test"
    auto_test
    pause
}

main
