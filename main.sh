#!/data/data/com.termux/files/usr/bin/bash
set -o pipefail

RED="\e[1;31m"; WHT="\e[1;37m"; B="\e[1m"; R="\e[0m"

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

clear; logo; menu
read -p "Pilih: " p
case $p in
1) modules/root_check.sh ;;
2) modules/system_info.sh ;;
3) modules/mount_rw.sh ;;
4) modules/hosts_block.sh ;;
5) modules/cpu_tweak.sh ;;
6) modules/gpu_tweak.sh ;;
7) modules/ram_cleaner.sh ;;
8) modules/thermal_off.sh ;;
9) modules/app_freezer.sh ;;
10) modules/app_unfreeze.sh ;;
11) modules/battery_saver.sh ;;
12) modules/io_tweak.sh ;;
13) modules/network_boost.sh ;;
14) modules/selinux_status.sh ;;
15) modules/selinux_permissive.sh ;;
16) modules/hide_root_basic.sh ;;
17) modules/service_manager.sh ;;
18) modules/reboot_menu.sh ;;
19) modules/storage_boost.sh ;;
20) modules/pkg_manager.sh ;;
21) modules/logcat_monitor.sh ;;
22) modules/kernel_tweak.sh ;;
23) modules/backup_apps.sh ;;
0) exit ;;
*) exec "$0" ;;
esac
