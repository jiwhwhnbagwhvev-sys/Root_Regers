#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

header "ROOT ACCESS TEST MODE"

echo "[*] Memulai uji coba root tingkat sistem"
sleep 0.5
line

# ===============================
# TEST 1: Binary Root
# ===============================
echo "[1] Cek binary root (tsu / su)"
if command -v tsu >/dev/null 2>&1; then
  ROOTCMD="tsu"
  echo "[✓] tsu ditemukan"
elif command -v su >/dev/null 2>&1; then
  ROOTCMD="su"
  echo "[✓] su ditemukan"
else
  echo "[✗] Tidak ada akses root"
  pause
  exit
fi

# ===============================
# TEST 2: UID ROOT
# ===============================
echo
echo "[2] Uji UID root (id)"
if $ROOTCMD -c "id | grep -q 'uid=0'"; then
  $ROOTCMD -c id
  echo "[✓] UID = 0 (ROOT)"
else
  echo "[✗] Bukan UID root"
fi

# ===============================
# TEST 3: WRITE /data
# ===============================
echo
echo "[3] Uji tulis direktori /data"
TESTFILE="/data/local/tmp/root_ragers_test.txt"

if $ROOTCMD -c "echo ROOT_OK > $TESTFILE" 2>/dev/null; then
  echo "[✓] Berhasil menulis ke /data"
  $ROOTCMD -c "cat $TESTFILE"
  $ROOTCMD -c "rm -f $TESTFILE"
else
  echo "[✗] Gagal menulis ke /data"
fi

# ===============================
# TEST 4: READ /proc
# ===============================
echo
echo "[4] Uji baca /proc"
if $ROOTCMD -c "cat /proc/version" >/dev/null 2>&1; then
  $ROOTCMD -c "cat /proc/version | head -n 1"
  echo "[✓] Akses /proc OK"
else
  echo "[✗] Tidak bisa akses /proc"
fi

# ===============================
# TEST 5: SYSFS ACCESS
# ===============================
echo
echo "[5] Uji akses sysfs CPU"
CPU_GOV="/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

if $ROOTCMD -c "[ -f $CPU_GOV ]"; then
  CUR_GOV=$($ROOTCMD -c "cat $CPU_GOV")
  echo "[✓] Governor terdeteksi: $CUR_GOV"
else
  echo "[!] Sysfs CPU tidak tersedia (kernel lock)"
fi

# ===============================
# RESULT
# ===============================
line
echo -e "${GRN}[✓] MODE UJI COBA ROOT SELESAI${RST}"
echo "[*] Perangkat ini memiliki akses root aktif"
line

pause
