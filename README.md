# Root_Regers

![Language](https://img.shields.io/badge/language-Bash-green)
![Framework](https://img.shields.io/badge/framework-Bash%20ID-green)
![Forks](https://img.shields.io/github/forks/username/repo)
![License](https://img.shields.io/github/license/username/repo)

# apa itu Root_Regers ???
Root Power Toolkit adalah toolkit berbasis Termux untuk perangkat Android yang sudah di‑root (Magisk/KernelSU). Menyediakan berbagai fitur nyata seperti CPU &amp; RAM tweak, thermal control, SELinux manager, app freezer, network dan storage optimization dalam satu tool modular berbasis CLI

# ROOT POWER TOOLKIT ☠

Root Power Toolkit adalah toolkit berbasis Termux untuk perangkat Android yang sudah di‑root (Magisk / KernelSU). Tool ini menyediakan berbagai fitur sistem tingkat lanjut seperti CPU & RAM tweak, thermal control, SELinux manager, app freezer, network dan storage optimization dalam satu CLI tool modular.

## ⚠️ Peringatan
Tool ini membutuhkan akses ROOT. Gunakan dengan bijak. Risiko ditanggung pengguna.

# apa fungsi fitur Account security scanner ???

Fitur Account Security Scanner ini dirancang sebagai alat analisis keamanan akun digital secara umum, mencakup akun game (seperti Free Fire, Mobile Legends, PUBG), akun online, dan akun berbasis ID lainnya. Fungsinya bukan untuk membobol akun, melainkan untuk mengecek tingkat keamanan akun dari sisi pengguna, seperti validasi format ID, status aktivitas akun (aktif/tidak), pola risiko umum (akun jarang diganti sandi, login di banyak perangkat, tidak ada proteksi tambahan), serta simulasi seberapa mudah akun tersebut menjadi target pencurian jika kebiasaan pengguna buruk. Dengan fitur ini, pengguna bisa memahami posisi keamanan akun mereka sendiri sebelum terjadi masalah seperti akun diambil alih atau terkena phising.

Keunggulan spesialnya ada pada pendekatan multi-akun dan edukatif: satu menu bisa digunakan untuk berbagai platform, hasilnya ditampilkan dalam indikator risiko (AMAN / WASPADA / RAWAN), lengkap dengan rekomendasi nyata yang bisa langsung diterapkan di dunia nyata (contoh: binding akun, pengamanan perangkat, kebiasaan login yang benar). Sistem ini juga bisa menyimpan log analisis agar pengguna bisa memantau perubahan tingkat keamanan akun dari waktu ke waktu. Jadi fitur ini cocok buat pengguna yang ingin melindungi akun-akunnya secara cerdas, bukan sekadar coba-coba atau melanggar aturan.

# Cara jalanin WiFi Intruder Scanne
salin kode termux ini biar wifi nya aktif dan bisa jalanin halaman fitur menu ini 
```
ip route
pkg install iproute2 iputils -y
```
# cek terlebih dahulu pake kode
ip route dan harus ada imput ini
- default via 192.168.1.1 dev wlan0

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
- WiFi Intruder Scanner
- Auto Spam Block Guard
- AI Sistem
- Account security scanner 

# Katasandi server kode
- USERNAME= Rio2026
- PASSWORD= Root_Rage 2026

# kalo kode nya eror
jalanin perintah di bawah ini
👇👇👇👇👇👇👇👇👇👇
salin semua kode ini paste ke termux
```
pwd
ls
r
m -rf modules
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
pkg install python -y
pkg install git
git clone https://github.com/jiwhwhnbagwhvev-sys/Root_Regers.git
cd Root_Regers
chmod +x main.sh modules/*.sh
./main.sh
