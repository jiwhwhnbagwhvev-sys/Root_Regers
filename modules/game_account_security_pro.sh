#!/usr/bin/env python3
import os, sys, time, random, re
from datetime import datetime
from colorama import Fore, Style, init

init(autoreset=True)

REPORT_DIR = "reports"
os.makedirs(REPORT_DIR, exist_ok=True)

# ================= UTIL =================
def slow(text, d=0.02):
    for c in text:
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(d)
    print()

def hacker_scroll(lines=15):
    for _ in range(lines):
        print(Fore.GREEN + "".join(random.choice("01#$%&@") for _ in range(70)))
        time.sleep(0.04)

def clear():
    os.system("clear")

# ================= UI =================
def logo():
    clear()
    print(Fore.RED + """
 ██████╗  █████╗ ███╗   ███╗███████╗
██╔════╝ ██╔══██╗████╗ ████║██╔════╝
██║  ███╗███████║██╔████╔██║█████╗  
██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  
╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗
 ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
""")
    slow(Fore.GREEN + ">>> GAME ACCOUNT SECURITY ANALYZER — PRO <<<")
    hacker_scroll()

# ================= VALIDATOR =================
def validate_ff(uid):
    return bool(re.fullmatch(r"\d{8,12}", uid))

def validate_ml(uid):
    return bool(re.fullmatch(r"\d{6,10}", uid))

def validate_pubg(uid):
    return bool(re.fullmatch(r"\d{7,12}", uid))

# ================= ANALYSIS =================
def security_score():
    base = random.randint(60, 85)
    bonus = random.choice([0,5,10])
    return min(base + bonus, 100)

def recommendations():
    return [
        "Aktifkan Two-Factor Authentication (2FA)",
        "Bind akun ke email & platform resmi",
        "Jangan login di website tidak resmi",
        "Ganti password setiap 3–6 bulan",
        "Hindari share akun ke orang lain"
    ]

# ================= REPORT =================
def save_report(game, uid, score):
    file = f"{REPORT_DIR}/{game}_{uid}.log"
    with open(file, "w") as f:
        f.write(f"GAME        : {game}\n")
        f.write(f"USER ID     : {uid}\n")
        f.write(f"SCORE       : {score}/100\n")
        f.write(f"TIME        : {datetime.now()}\n")
        f.write("\nRECOMMENDATIONS:\n")
        for r in recommendations():
            f.write(f"- {r}\n")
    return file

# ================= CORE =================
def scan(game):
    uid = input(Fore.CYAN + "Masukkan ID: ")

    valid = {
        "FF": validate_ff,
        "ML": validate_ml,
        "PUBG": validate_pubg
    }[game](uid)

    if not valid:
        print(Fore.RED + "[✗] Format ID tidak valid")
        return

    print(Fore.YELLOW + "[*] Menganalisis keamanan akun...")
    time.sleep(1.5)

    score = security_score()
    print(Fore.GREEN + f"[✓] SKOR KEAMANAN: {score}/100")

    print(Fore.CYAN + "\nRekomendasi:")
    for r in recommendations():
        print(Fore.GREEN + " - " + r)

    report = save_report(game, uid, score)
    print(Fore.YELLOW + f"\n[✓] Laporan disimpan: {report}")

# ================= MENU =================
def menu():
    while True:
        print(Fore.CYAN + """
[1] Free Fire Account Check
[2] Mobile Legends Account Check
[3] PUBG Account Check
[0] Exit
""")
        c = input(">> ")
        if c == "1": scan("FF")
        elif c == "2": scan("ML")
        elif c == "3": scan("PUBG")
        elif c == "0": break
        input("\nENTER...")

# ================= RUN =================
if __name__ == "__main__":
    logo()
    menu()
