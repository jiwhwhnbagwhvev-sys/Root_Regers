#!/usr/bin/env python3
# ==========================================
# GAME ACCOUNT SECURITY ENGINE
# ==========================================

import re
import sys
import hashlib
import random
import time

def banner():
    print("""
██████╗  █████╗ ███╗   ███╗███████╗
██╔══██╗██╔══██╗████╗ ████║██╔════╝
██████╔╝███████║██╔████╔██║█████╗  
██╔═══╝ ██╔══██║██║╚██╔╝██║██╔══╝  
██║     ██║  ██║██║ ╚═╝ ██║███████╗
╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
GAME ACCOUNT SECURITY ENGINE
""")

def risk_score(game, acc_id, nickname):
    score = 0
    reasons = []

    if len(acc_id) < 8:
        score += 30
        reasons.append("ID terlalu pendek (mudah ditebak)")

    if acc_id.isdigit():
        score += 20
        reasons.append("ID hanya angka (rentan brute guess)")

    common_names = ["player", "guest", "pro", "noob", "dark"]
    if nickname.lower() in common_names:
        score += 20
        reasons.append("Nickname terlalu umum")

    if re.search(r"\d{4,}", nickname):
        score += 10
        reasons.append("Nickname pakai angka pola umum")

    if random.randint(0, 1):
        score += 10
        reasons.append("Pola ID sering muncul di laporan phising")

    if score < 30:
        level = "AMAN"
    elif score < 60:
        level = "SEDANG"
    else:
        level = "TINGGI"

    return score, level, reasons

def run():
    banner()
    game = input("Game (FF / ML / PUBG): ").strip().upper()
    acc_id = input("Masukkan ID Akun: ").strip()
    nickname = input("Masukkan Nickname (opsional): ").strip() or "unknown"

    print("\n[+] Menganalisis keamanan akun...")
    time.sleep(1.5)

    score, level, reasons = risk_score(game, acc_id, nickname)

    print("\n=== HASIL ANALISIS ===")
    print(f"Game        : {game}")
    print(f"Account ID  : {acc_id}")
    print(f"Nickname    : {nickname}")
    print(f"Risk Score  : {score}/100")
    print(f"Status      : {level}")

    print("\nIndikator Risiko:")
    for r in reasons:
        print(f"- {r}")

    print("\nRekomendasi:")
    print("- Aktifkan 2FA / verifikasi tambahan")
    print("- Jangan share ID + nickname bersamaan")
    print("- Hindari login via link tidak resmi")
    print("- Gunakan email & password unik")

if __name__ == "__main__":
    run()
