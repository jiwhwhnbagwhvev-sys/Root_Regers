import os, sys, time, random, socket, platform, subprocess

# ====== UTIL ======
def clear():
    os.system("clear")

def slow(t, d=0.02):
    for c in t:
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(d)
    print()

def hacker_scroll():
    for _ in range(18):
        print("\033[32m" + "".join(random.choice("01#@$%&") for _ in range(70)))
        time.sleep(0.04)
    print("\033[0m")

def logo():
    clear()
    print("\033[31m")
    print(r"""
██████╗  █████╗ ██████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝
██║  ██║███████║██████╔╝█████╔╝ 
██║  ██║██╔══██║██╔══██╗██╔═██╗ 
██████╔╝██║  ██║██║  ██║██║  ██╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
      DARK CODING LAB
""")
    print("\033[0m")
    slow(">>> INITIALIZING KNOWLEDGE CORE <<<")
    hacker_scroll()

def pause():
    input("\nENTER untuk lanjut...")

# ====== MENU AKSI (20) ======
def m1(): print("Hello World — Python jalan.")
def m2():
    x=10; y=20
    print("Variabel:", x, y, "Jumlah:", x+y)

def m3():
    n=input("Nama kamu: ")
    print("Halo,", n)

def m4():
    n=int(input("Angka: "))
    print("GENAP" if n%2==0 else "GANJIL")

def m5():
    for i in range(5): print("For loop:", i)

def m6():
    i=0
    while i<5:
        print("While:", i); i+=1

def m7():
    a=[1,2,3,4]; print("List:", a)

def m8():
    d={"user":"root","mode":"learn"}
    print("Dict:", d)

def m9():
    def tambah(a,b): return a+b
    print("Fungsi:", tambah(7,5))

def m10():
    with open("learn_log.txt","a") as f:
        f.write("Belajar coding\n")
    print("File ditulis: learn_log.txt")

def m11():
    if os.path.exists("learn_log.txt"):
        print(open("learn_log.txt").read())
    else:
        print("File belum ada")

def m12():
    print("OS:", platform.system(), platform.release())

def m13():
    host=socket.gethostname()
    print("Hostname:", host)
    print("IP:", socket.gethostbyname(host))

def m14():
    os.system("ping -c 3 8.8.8.8")

def m15():
    print("Membuat folder project_demo")
    os.makedirs("project_demo", exist_ok=True)

def m16():
    open("project_demo/app.py","w").write("print('Project Jalan')")
    print("File project_demo/app.py dibuat")

def m17():
    print("Menjalankan server lokal http://0.0.0.0:8080")
    subprocess.call([sys.executable, "-m", "http.server", "8080"])

def m18():
    pwd="".join(random.choice("abcdef123456") for _ in range(12))
    print("Password acak:", pwd)

def m19():
    cmd=input("Perintah shell (contoh: ls): ")
    os.system(cmd)

def m20():
    print("Belajar selesai. Kamu naik level.")

ACTIONS = {
"1":m1,"2":m2,"3":m3,"4":m4,"5":m5,
"6":m6,"7":m7,"8":m8,"9":m9,"10":m10,
"11":m11,"12":m12,"13":m13,"14":m14,"15":m15,
"16":m16,"17":m17,"18":m18,"19":m19,"20":m20
}

# ====== MENU ======
def menu():
    while True:
        clear()
        print("""
01 Hello World
02 Variabel & Operasi
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
13 Network Info
14 Ping Test
15 Buat Folder
16 Buat Project File
17 Web Server Lokal
18 Password Generator
19 Shell Command
20 Finish Learning
00 Exit
""")
        c=input(">> ")
        if c=="0": break
        if c in ACTIONS:
            ACTIONS[c]()
            pause()

if __name__=="__main__":
    logo()
    menu()
