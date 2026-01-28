import os
import time
import sys
import random
import socket
import psutil
from colorama import Fore, Style, init
init(autoreset=True)

def slow(text, d=0.02):
    for c in text:
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(d)
    print()

def hacker_scroll():
    for _ in range(20):
        line = "".join(random.choice("01#@$%&") for _ in range(60))
        print(Fore.GREEN + line)
        time.sleep(0.05)

def logo():
    os.system("clear")
    print(Fore.RED + """
██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ 
██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
███████║███████║██║     █████╔╝ █████╗  ██████╔╝
██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
    """)
    slow(Fore.GREEN + ">>> SYSTEM BREACH INITIATED <<<")
    hacker_scroll()

# ================= MENU AKSI =================
def hello():
    print("Hello World from DARK LAB")

def variable():
    x = 666
    print("Nilai x =", x)

def user_input():
    n = input("Masukkan nama: ")
    print("Halo", n)

def if_else():
    n = int(input("Angka: "))
    print("GENAP" if n % 2 == 0 else "GANJIL")

def loop_for():
    for i in range(5):
        print("Loop", i)

def loop_while():
    i = 0
    while i < 5:
        print("While", i)
        i += 1

def list_demo():
    a = [1,2,3,4]
    print(a)

def dict_demo():
    d = {"user":"root","level":"dark"}
    print(d)

def function_demo():
    def hitung(a,b): return a+b
    print(hitung(5,7))

def file_write():
    with open("dark_log.txt","a") as f:
        f.write("ACCESS\n")
    print("File ditulis")

def file_read():
    print(open("dark_log.txt").read())

def system_info():
    print(os.uname())

def cpu_ram():
    print("CPU:", psutil.cpu_percent(),"%")
    print("RAM:", psutil.virtual_memory().percent,"%")

def net_info():
    print("IP:", socket.gethostbyname(socket.gethostname()))

def ping():
    os.system("ping -c 3 8.8.8.8")

def web_check():
    h = input("Domain (contoh google.com): ")
    try:
        socket.gethostbyname(h)
        print("Website hidup")
    except:
        print("Website mati")

def web_server():
    os.system("python -m http.server 8080")

def password():
    p = "".join(random.choice("abcdef123456") for _ in range(12))
    print("Password:", p)

def log_activity():
    with open("activity.log","a") as f:
        f.write(time.ctime()+"\n")
    print("Aktivitas dicatat")

def mini_project():
    os.makedirs("mini_project", exist_ok=True)
    open("mini_project/main.py","w").write("print('Mini Project Jalan')")
    print("Mini project dibuat")

# ================= MENU =================
def menu():
    while True:
        print(Fore.CYAN + """
01 Hello World
02 Variabel
03 Input User
04 If Else
05 Loop For
06 Loop While
07 List
08 Dictionary
09 Function
10 File Write
11 File Read
12 System Info
13 CPU & RAM
14 Network Info
15 Ping Test
16 Website Check
17 Web Server
18 Password Generator
19 Log Activity
20 Mini Project
00 Exit
""")
        c = input(">> ")
        if c=="1": hello()
        elif c=="2": variable()
        elif c=="3": user_input()
        elif c=="4": if_else()
        elif c=="5": loop_for()
        elif c=="6": loop_while()
        elif c=="7": list_demo()
        elif c=="8": dict_demo()
        elif c=="9": function_demo()
        elif c=="10": file_write()
        elif c=="11": file_read()
        elif c=="12": system_info()
        elif c=="13": cpu_ram()
        elif c=="14": net_info()
        elif c=="15": ping()
        elif c=="16": web_check()
        elif c=="17": web_server()
        elif c=="18": password()
        elif c=="19": log_activity()
        elif c=="20": mini_project()
        elif c=="0": break
        input("\nENTER...")

if __name__ == "__main__":
    logo()
    menu()
