#!/data/data/com.termux/files/usr/bin/bash
# ==========================================================
# HP SECURITY GUARD — ROOT_RAGERS
# ==========================================================

MODULE="HP SECURITY GUARD"
BASE="$HOME/Root_Regers"
DATA="$BASE/data"
LOG="/data/local/tmp/root_ragers.log"
SCANLOG="$DATA/security_scan.log"

R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"
C="\e[1;36m"; M="\e[1;35m"; B="\e[1m"; W="\e[1;37m"

mkdir -p "$DATA"

pause(){ read -rp "ENTER untuk kembali..."; }
log(){ echo "[$(date '+%F %T')] $MODULE : $1" >> "$LOG"; }

# ================= HEADER =================
header(){
clear
echo -e "${C}${B}"
echo "╔════════════════════════════════════════╗"
echo "║          HP SECURITY GUARD            ║"
echo "╚════════════════════════════════════════╝"
echo -e "${R}"
echo -e "${Y}• Scan Apps • Scan Files • Spam/Scam Check${R}\n"
}

# ================= HACKER UI =================
hacker_ui(){
clear
for i in {1..12}; do
  printf "${M}INITIALIZING SECURITY PROTOCOLS [%02d%%]\n" "$((RANDOM%90+10))"
  printf "SCANNING SYSTEM FILES ............\n"
  printf "ANALYZING APPS & PERMISSIONS ......\n"
  sleep 0.08
  clear
done
}

# ================= SCAN APPS =================
scan_apps(){
echo -e "${Y}[*] Mendeteksi aplikasi mencurigakan...${R}"
pm list packages -3 > "$DATA/apps.txt" 2>/dev/null
SUSPICIOUS=0
while read -r pkg; do
    if [[ "$pkg" =~ "unknown"|"test"|".debug" ]]; then
        echo -e "${RED}[✗] $pkg Mencurigakan${R}"
        SUSPICIOUS=$((SUSPICIOUS+1))
        echo "$pkg" >> "$SCANLOG"
    fi
done < "$DATA/apps.txt"

echo -e "${G}[✓] Scan Apps selesai — $SUSPICIOUS aplikasi mencurigakan ditemukan${R}"
log "Apps scan: $SUSPICIOUS suspicious apps"
}

# ================= SCAN FILES =================
scan_files(){
echo -e "${Y}[*] Memindai folder download dan apk...${R}"
FILES=$(find $HOME/Download -type f -iname "*.apk" 2>/dev/null)
MALWARE=0
for f in $FILES; do
    # Cek sederhana: ukuran aneh (>100MB)
    SIZE=$(du -m "$f" | awk '{print $1}')
    if [ "$SIZE" -gt 100 ]; then
        echo -e "${RED}[✗] $f ukurannya mencurigakan (${SIZE}MB)${R}"
        MALWARE=$((MALWARE+1))
        echo "$f" >> "$SCANLOG"
    fi
done
echo -e "${G}[✓] Scan Files selesai — $MALWARE file mencurigakan${R}"
log "Files scan: $MALWARE suspicious files"
}

# ================= SPAM/SCAM CHECK =================
spam_check(){
echo -e "${Y}[*] Memeriksa nomor spam / scam...${R}"
BLOCKLIST="$DATA/blocklist.txt"
if [ -f "$BLOCKLIST" ]; then
    COUNT=$(wc -l < "$BLOCKLIST")
    echo -e "${G}[✓] $COUNT nomor terindikasi spam / scam ditemukan${R}"
else
    echo -e "${Y}[i] Tidak ada daftar blocklist${R}"
fi
}

# ================= PERMISSION CHECK =================
permission_check(){
echo -e "${Y}[*] Memeriksa izin aplikasi berlebihan...${R}"
PERM_OVER=0
while read -r pkg; do
    PERM=$(dumpsys package "$pkg" | grep permission)
    if [[ "$PERM" =~ "READ_SMS"|"ACCESS_FINE_LOCATION"|"RECORD_AUDIO" ]]; then
        echo -e "${RED}[✗] $pkg meminta izin berlebihan${R}"
        PERM_OVER=$((PERM_OVER+1))
        echo "$pkg | $PERM" >> "$SCANLOG"
    fi
done < "$DATA/apps.txt"
echo -e "${G}[✓] Permission scan selesai — $PERM_OVER aplikasi berisiko${R}"
log "Permissions: $PERM_OVER risky apps"
}

# ================= REKOMENDASI =================
recommendations(){
echo -e "${C}${B}\nREKOMENDASI KEAMANAN HP:${R}"
echo -e "${Y}- Hapus / uninstall aplikasi mencurigakan"
echo -e "- Hapus file .apk besar / unknown"
echo -e "- Blok nomor spam (lihat Auto Spam Block Guard)"
echo -e "- Batasi izin berlebihan aplikasi"
echo -e "- Selalu update OS & apps"
}

# ================= MAIN =================
main(){
header
hacker_ui
scan_apps
scan_files
spam_check
permission_check
recommendations
pause
}

main
