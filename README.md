# Root_Regers
Root Power Toolkit adalah toolkit berbasis Termux untuk perangkat Android yang sudah di‑root (Magisk/KernelSU). Menyediakan berbagai fitur nyata seperti CPU &amp; RAM tweak, thermal control, SELinux manager, app freezer, network dan storage optimization dalam satu tool modular berbasis CLI

# ROOT POWER TOOLKIT ☠

Root Power Toolkit adalah toolkit berbasis Termux untuk perangkat Android yang sudah di‑root (Magisk / KernelSU). Tool ini menyediakan berbagai fitur sistem tingkat lanjut seperti CPU & RAM tweak, thermal control, SELinux manager, app freezer, network dan storage optimization dalam satu CLI tool modular.

## ⚠️ Peringatan
Tool ini membutuhkan akses ROOT. Gunakan dengan bijak. Risiko ditanggung pengguna.

## ✨ Fitur
- Root Check
- System Information
- Mount System RW
- Hosts Adblock
- CPU Performance Tweak
- GPU Boost
- RAM Cleaner
- Disable Thermal Service
- Freeze & Unfreeze App
- Battery Saver
- IO Scheduler Tweak
- Network Boost
- SELinux Status & Permissive
- Basic Root Hide
- Service Manager
- Reboot Menu
- Storage Trim
- Package Manager
- Logcat Monitor
- Kernel Info
- Backup Aplikasi
  
# Cara jalanin modules biar berfungsi fitur nya
salin semua kode ini paste ke termux
```
pwd
ls
rm -rf modules
mkdir modules
ls modules
mv \
root_check.sh system_info.sh mount_rw.sh hosts_block.sh \
cpu_tweak.sh gpu_tweak.sh ram_cleaner.sh thermal_off.sh \
app_freezer.sh app_unfreeze.sh battery_saver.sh io_tweak.sh \
network_boost.sh selinux_status.sh selinux_permissive.sh \
hide_root_basic.sh service_manager.sh reboot_menu.sh \
storage_boost.sh pkg_manager.sh logcat_monitor.sh \
modules/
ls modules
chmod +x main.sh login.sh
chmod +x modules/*.sh
ls -l modules/root_check.sh
./modules/root_check.sh
./main.sh
```
## 📦 Instalasi (Termux)

```bash
pkg update -y && pkg upgrade -y
pkg install git tsu -y
git clone https://github.com/jiwhwhnbagwhvev-sys/Root_Regers.git
cd Root_Regers
chmod +x main.sh modules/*.sh
./main.sh
