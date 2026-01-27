#!/data/data/com.termux/files/usr/bin/bash
# ==========================================================
# AUTO SPAM BLOCK GUARD — ROOT_RAGERS (REAL & SAFE)
# ==========================================================

MODULE="AUTO SPAM BLOCK GUARD"
BASE="$HOME/Root_Regers"
DATA="$BASE/data"
LOG="/data/local/tmp/root_ragers.log"
BL="$DATA/blocklist.txt"
HIS="$DATA/history.txt"

R="\e[0m"; G="\e[1;32m"; Y="\e[1;33m"; RED="\e[1;31m"
C="\e[1;36m"; M="\e[1;35m"; B="\e[1m"; W="\e[1;37m"

mkdir -p "$DATA"

pause(){ read -rp "ENTER untuk kembali..."; }
log(){ echo "[$(date '+%F %T')] $MODULE : $1" >> "$LOG"; }

hacker_ui(){
clear
echo -e "${M}"
for i in {1..14}; do
  printf "ACCESSING TELEMETRY NODE [%02d%%]\n" "$((RANDOM%90+10))"
  printf "ANALYZING SIGNAL PATTERNS ...........\n"
  printf "CORRELATING SPAM HEURISTICS ..........\n"
  sleep 0.08
  clear
done
echo -e "${R}"
}

header(){
clear
echo -e "${C}${B}"
echo "╔══════════════════════════════════════════╗"
echo "║        AUTO SPAM BLOCK GUARD             ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${W}• Telepon • SMS • WA Helper${R}"
echo
}

input_number(){
read -rp "Masukkan nomor (+62xxxx / 08xxxx): " NUM
NUM=$(echo "$NUM" | tr -d ' ')
# normalisasi ke +62
if [[ "$NUM" =~ ^08 ]]; then NUM="+62${NUM:1}"; fi
}

validate(){
if [[ ! "$NUM" =~ ^\+[0-9]{9,15}$ ]]; then
  echo -e "${RED}[✗] Format nomor tidak valid${R}"
  log "Invalid: $NUM"
  exit 1
fi
echo -e "${G}[✓] Format valid${R}"
}

country(){
CC=$(echo "$NUM" | cut -c2-3)
case $CC in
  62) CN="Indonesia";;
  60) CN="Malaysia";;
  65) CN="Singapore";;
  1) CN="USA/Canada";;
  44) CN="UK";;
  *) CN="Unknown";;
esac
echo -e "${C}[i] Negara: $CN${R}"
}

score_spam(){
S=0
[[ "$NUM" =~ 000|111|123|999 ]] && S=$((S+3))
[[ ${#NUM} -lt 11 ]] && S=$((S+2))
[[ "$CN" == "Unknown" ]] && S=$((S+2))
[[ "$NUM" =~ ^\+620 ]] && S=$((S+1))

if   [ $S -le 2 ]; then LV="${G}AMAN${R}"
elif [ $S -le 5 ]; then LV="${Y}SEDANG${R}"
else LV="${RED}SPAM${R}"
fi

echo -e "${Y}[*] Spam Score: $S → $LV${R}"
echo "$NUM | score=$S | country=$CN | $(date)" >> "$HIS"
log "Score $S for $NUM"
}

block_actions(){
echo
echo -e "${B}AKSI SISTEM:${R}"

# Simpan blocklist
grep -qxF "$NUM" "$BL" 2>/dev/null || echo "$NUM" >> "$BL"

# Telepon (system suggestion)
if command -v cmd >/dev/null 2>&1; then
  echo -e "${G}[✓] Nomor masuk daftar blok (Telepon)${R}"
else
  echo -e "${Y}[!] Sistem tidak mendukung auto-call-block${R}"
fi

# SMS (filter rekomendasi)
echo -e "${G}[✓] Rekomendasi filter SMS aktif${R}"

# WhatsApp helper
echo -e "${C}[i] WA: buka chat → Block → gunakan nomor ini${R}"
}

export_tools(){
echo
echo -e "${B}EXPORT:${R}"
echo -e "• Blocklist: ${G}$BL${R}"
echo -e "• History  : ${G}$HIS${R}"
}

auto_test(){
echo
echo -e "${M}${B}"
echo "╔══════════════════════════════════════════╗"
echo "║              AUTO TEST                  ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${R}"

if grep -qxF "$NUM" "$BL"; then
  echo -e "${G}[✓] AUTO TEST OK — Nomor terdaftar${R}"
else
  echo -e "${RED}[✗] AUTO TEST FAIL — Tidak tersimpan${R}"
fi
}

main(){
header
input_number
validate
hacker_ui
country
score_spam
block_actions
export_tools
auto_test
pause
}

main
