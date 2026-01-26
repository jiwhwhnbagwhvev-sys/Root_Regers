
#!/data/data/com.termux/files/usr/bin/bash
. ./modules/_common.sh

MODUL="Disable Thermal"
echo "[*] Menjalankan $MODUL"
loading

need_root
tsu -c 'for t in /sys/class/thermal/thermal_zone*/mode; do echo disabled > $t 2>/dev/null; done'

back
