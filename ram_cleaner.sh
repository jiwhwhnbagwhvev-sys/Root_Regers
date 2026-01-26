
#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

MODUL="RAM Cleaner"
echo "[*] Menjalankan $MODUL"
loading

need_root
tsu -c "sync; echo 3 > /proc/sys/vm/drop_caches"
free -h

back
