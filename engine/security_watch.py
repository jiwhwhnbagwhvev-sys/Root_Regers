#!/usr/bin/env python3
# ======================================================
# SECURITY WATCH SYSTEM — DARK HEKER EDITION
# ======================================================

import os
import stat
import time
from datetime import datetime

# WARNA
R = "\033[0m"
G = "\033[1;32m"
Y = "\033[1;33m"
RED = "\033[1;31m"
C = "\033[1;36m"
P = "\033[1;35m"
B = "\033[1m"

LOG = "/data/local/tmp/security_watch.log"

WATCH_FOLDERS = [
    "/sdcard/Download",
    "/sdcard/Android/data",
    "/data/local/tmp"
]

SUSPICIOUS_EXT = [".apk", ".exe", ".jar", ".sh", ".py"]
HIGH_RISK_NAMES = ["hack", "crack", "keylogger", "rat", "spy", "inject"]

def log(msg):
    with open(LOG, "a") as f:
        f.write(f"[{datetime.now()}] {msg}\n")

def slow(text, delay=0.015):
    for c in text:
        print(c, end="", flush=True)
        time.sleep(delay)
    print()

def banner():
    os.system("clear")
    print(f"""{RED}{B}
███████╗███████╗ ██████╗ ██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
██╔════╝██╔════╝██╔════╝ ██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
███████╗█████╗  ██║  ███╗██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
╚════██║██╔══╝  ██║   ██║██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
███████║███████╗╚██████╔╝╚██████╔╝██║  ██║██║   ██║      ██║   
╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   
{R}{P}
      >>> SECURITY WATCH SYSTEM <<<
      >>>    Rio security 2026     <<<
{R}
""")

def is_world_writable(path):
    try:
        return bool(os.stat(path).st_mode & stat.S_IWOTH)
    except:
        return False

def scan_folder(folder):
    alerts = []
    for root, dirs, files in os.walk(folder):
        for name in files:
            path = os.path.join(root, name)
            lname = name.lower()

            # ekstensi mencurigakan
            for ext in SUSPICIOUS_EXT:
                if lname.endswith(ext):
                    alerts.append((2, f"File mencurigakan: {path}"))

            # nama berbahaya
            for key in HIGH_RISK_NAMES:
                if key in lname:
                    alerts.append((3, f"File HIGH RISK: {path}"))

            # permission bahaya
            if is_world_writable(path):
                alerts.append((3, f"Permission 777 terdeteksi: {path}"))

    return alerts

def threat_level(score):
    if score == 0:
        return f"{G}AMAN{R}"
    if score <= 3:
        return f"{Y}SEDANG{R}"
    return f"{RED}BERBAHAYA{R}"

def main():
    banner()
    slow(f"{C}[+] Initializing security scan engine...{R}")
    time.sleep(0.5)

    total_score = 0
    findings = []

    for folder in WATCH_FOLDERS:
        if os.path.exists(folder):
            slow(f"{Y}[SCAN] {folder}{R}")
            results = scan_folder(folder)
            for lvl, msg in results:
                findings.append(msg)
                total_score += lvl
                log(msg)

    print(f"\n{B}=== HASIL ANALISA ==={R}")
    if not findings:
        print(f"{G}[✓] Tidak ditemukan ancaman{R}")
        log("SYSTEM CLEAN")
    else:
        for f in findings[:20]:
            print(f"{RED}[!] {f}{R}")

        if len(findings) > 20:
            print(f"{Y}...dan lainnya{R}")

    print(f"\n{B}LEVEL ANCAMAN:{R} {threat_level(total_score)}")

    print(f"""
{P}[REKOMENDASI]
- Jangan install APK sembarangan
- Hapus file berisiko tinggi
- Cek izin aplikasi
- Aktifkan Play Protect
{R}
""")

    input(f"{C}ENTER untuk keluar dari Security Watch...{R}")

if __name__ == "__main__":
    main()
