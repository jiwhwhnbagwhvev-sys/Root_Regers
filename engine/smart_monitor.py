#!/usr/bin/env python3
# ======================================================
# SMART SYSTEM MONITOR
# Real-time Device Health Analyzer
# ======================================================

import os
import time
import subprocess
from datetime import datetime

LOG = "/data/local/tmp/smart_monitor.log"

def log(msg):
    with open(LOG, "a") as f:
        f.write(f"[{datetime.now()}] {msg}\n")

def run(cmd):
    try:
        return subprocess.check_output(cmd, shell=True, text=True).strip()
    except:
        return "N/A"

def banner():
    os.system("clear")
    print("""
███████╗███╗   ███╗ █████╗ ██████╗ ████████╗
██╔════╝████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝
███████╗██╔████╔██║███████║██████╔╝   ██║   
╚════██║██║╚██╔╝██║██╔══██║██╔══██╗   ██║   
███████║██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   
╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   

SMART SYSTEM MONITOR
""")

def cpu_info():
    freq = run("cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq")
    temp = run("cat /sys/class/thermal/thermal_zone0/temp")
    return freq, temp

def ram_info():
    return run("free -m")

def storage_info():
    return run("df -h /data")

def battery_info():
    base = "/sys/class/power_supply/battery"
    if os.path.exists(base):
        cap = run(f"cat {base}/capacity")
        stat = run(f"cat {base}/status")
        return cap, stat
    return "N/A", "N/A"

def network_info():
    ip = run("ip route get 8.8.8.8 | awk '{print $7}'")
    conn = run("ss -tun | wc -l")
    return ip, conn

def health_score(cpu_temp, ram_text):
    score = 100
    try:
        temp = int(cpu_temp) / 1000
        if temp > 45: score -= 15
        if temp > 55: score -= 30
        if temp > 65: score -= 50
    except:
        pass

    if "available" in ram_text:
        try:
            free = int(ram_text.split()[7])
            if free < 500: score -= 20
            if free < 300: score -= 40
        except:
            pass

    return max(score, 0)

def grade(score):
    if score >= 85: return "EXCELLENT"
    if score >= 70: return "GOOD"
    if score >= 50: return "FAIR"
    if score >= 30: return "POOR"
    return "CRITICAL"

def main():
    banner()
    log("Monitor started")

    cpu_freq, cpu_temp = cpu_info()
    ram = ram_info()
    storage = storage_info()
    bat_cap, bat_stat = battery_info()
    ip, conns = network_info()

    score = health_score(cpu_temp, ram)

    print("=== DEVICE STATUS ===")
    print(f"CPU Freq     : {cpu_freq}")
    print(f"CPU Temp     : {cpu_temp}")
    print(f"Battery      : {bat_cap}% ({bat_stat})")
    print(f"IP Address   : {ip}")
    print(f"Connections  : {conns}")

    print("\n=== RAM ===")
    print(ram)

    print("\n=== STORAGE ===")
    print(storage)

    print("\n=== HEALTH ===")
    print(f"Score : {score}/100")
    print(f"Grade : {grade(score)}")

    if score < 50:
        print("\n[!] WARNING: Perangkat tidak sehat")
        print("- Tutup aplikasi berat")
        print("- Bersihkan RAM")
        print("- Cek suhu")
    else:
        print("\n[✓] Sistem stabil")

    log(f"Score={score}, Temp={cpu_temp}, Battery={bat_cap}")
    input("\nENTER untuk keluar...")

if __name__ == "__main__":
    main()
