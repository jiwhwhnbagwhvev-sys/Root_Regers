#!/data/data/com.termux/files/usr/bin/bash

# ===== LOGIN =====
bash ./login.sh || exit 1

# ===== LOADING =====
loading() {
clear
text="LOGIN SUCCESS — WELCOME Rio2026"
colors=(31 32 33 34 35 36)
for i in {1..3}; do
  for c in "${colors[@]}"; do
    echo -ne "\033[${c}m$text\033[0m\r"
    sleep 0.15
  done
done
echo
sleep 0.8
}

loading   # <<< INI YANG KURANG

# ===== WARNA =====
RED="\e[1;31m"; WHT="\e[1;37m"; B="\e[1m"; R="\e[0m"

# ===== LOGO =====
logo() {
echo -e "${RED}${B}
██████╗  ██████╗  ██████╗ ████████╗
██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝
██████╔╝██║   ██║██║   ██║   ██║
██╔══██╗██║   ██║██║   ██║   ██║
██║  ██║╚██████╔╝╚██████╔╝   ██║
╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝
        ROOT_RAGERS ☠
${R}"
}

# ===== MENU =====
menu() {
echo -e "${WHT}
1 Root Check        9 Freeze App        17 Service Manager
2 System Info       10 Unfreeze App     18 Reboot Menu
3 Mount RW          11 Battery Saver    19 Storage Boost
4 Hosts Adblock     12 IO Tweak         20 Package Manager
5 CPU Performance   13 Network Boost    21 Logcat Monitor
6 GPU Boost         14 SELinux Status   22 Kernel Info
7 RAM Cleaner       15 SELinux Perm     23 Backup Apps
8 Disable Thermal   16 Basic Root Hide  0 Exit
${R}"
}

# ===== LOOP UTAMA =====
while true; do
    clear
    logo
    menu
    read -r -p "Pilih: " p
    case "$p" in
        1)  bash modules/root_check.sh ;;
        2)  bash modules/system_info.sh ;;
        3)  bash modules/mount_rw.sh ;;
        4)  bash modules/hosts_block.sh ;;
        5)  bash modules/cpu_tweak.sh ;;
        6)  bash modules/gpu_tweak.sh ;;
        7)  bash modules/ram_cleaner.sh ;;
        8)  bash modules/thermal_off.sh ;;
        9)  bash modules/app_freezer.sh ;;
        10) bash modules/app_unfreeze.sh ;;
        11) bash modules/battery_saver.sh ;;
        12) bash modules/io_tweak.sh ;;
        13) bash modules/network_boost.sh ;;
        14) bash modules/selinux_status.sh ;;
        15) bash modules/selinux_permissive.sh ;;
        16) bash modules/hide_root_basic.sh ;;
        17) bash modules/service_manager.sh ;;
        18) bash modules/reboot_menu.sh ;;
        19) bash modules/storage_boost.sh ;;
        20) bash modules/pkg_manager.sh ;;
        21) bash modules/logcat_monitor.sh ;;
        22) bash modules/kernel_tweak.sh ;;
        23) bash modules/backup_apps.sh ;;
        0)  echo "[✓] Keluar..."; exit ;;
        *)  echo "[!] Pilihan salah"; sleep 1 ;;
    esac
done
