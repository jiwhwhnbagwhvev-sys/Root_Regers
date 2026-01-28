import os, time, random, sys

LOG_FILE = "account_security.log"

def slow(txt, d=0.02):
    for c in txt:
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(d)
    print()

def clear():
    os.system("clear")

def hacker_anim():
    for _ in range(15):
        print("".join(random.choice("01#@$%") for _ in range(65)))
        time.sleep(0.04)

def logo():
    clear()
    print("""
██████╗  █████╗ ██████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝
██║  ██║███████║██████╔╝█████╔╝ 
██║  ██║██╔══██║██╔══██╗██╔═██╗ 
██████╔╝██║  ██║██║  ██║██║  ██╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
 GAME ACCOUNT SECURITY AI
""")
    slow(">> ANALYZING DIGITAL IDENTITY <<")
    hacker_anim()

# ===== SECURITY CORE =====
def log(data):
    with open(LOG_FILE, "a") as f:
        f.write(data + "\n")

def risk_level(score):
    if score >= 80:
        return "SANGAT KUAT"
    elif score >= 55:
        return "CUKUP AMAN"
    else:
        return "RENTAN"

def analyze(game):
    clear()
    print(f"[+] GAME: {game}")
    uid = input("Masukkan ID Akun: ")

    score = 0

    if uid.isdigit():
        score += 25
    if len(uid) >= 8:
        score += 20

    print("\n[?] Jawab dengan y/n")
    bind = input("Akun sudah bind email/sosmed? ")
    if bind.lower() == "y":
        score += 20

    pw = input("Password unik & tidak dipakai di tempat lain? ")
    if pw.lower() == "y":
        score += 15

    phish = input("Pernah login di web tidak resmi? ")
    if phish.lower() == "n":
        score += 20

    level = risk_level(score)

    print("\n========== HASIL ==========")
    print("Skor Keamanan :", score)
    print("Status Akun   :", level)

    if level != "SANGAT KUAT":
        print("\nREKOMENDASI:")
        print("- Ganti password")
        print("- Aktifkan bind email / 2FA")
        print("- Jangan login di web random")
        print("- Jangan share OTP")

    log(f"{game} | ID:{uid} | SCORE:{score} | STATUS:{level}")
    input("\nENTER untuk kembali...")

# ===== MENU =====
def menu():
    while True:
        clear()
        print("""
01 Free Fire Account Check
02 Mobile Legends Account Check
03 PUBG Mobile Account Check
04 View Security Log
00 Exit
""")
        c = input(">> ")

        if c == "1":
            analyze("FREE FIRE")
        elif c == "2":
            analyze("MOBILE LEGENDS")
        elif c == "3":
            analyze("PUBG MOBILE")
        elif c == "4":
            clear()
            if os.path.exists(LOG_FILE):
                print(open(LOG_FILE).read())
            else:
                print("Log kosong")
            input("\nENTER...")
        elif c == "0":
            break

if __name__ == "__main__":
    logo()
    menu()
