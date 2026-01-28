#!/usr/bin/env python3
import subprocess
import statistics
import time

def ping_test(target="8.8.8.8", count=10):
    cmd = ["ping", "-c", str(count), target]
    p = subprocess.run(cmd, capture_output=True, text=True)
    lines = p.stdout.splitlines()

    rtt = []
    loss = 0

    for l in lines:
        if "time=" in l:
            try:
                rtt.append(float(l.split("time=")[1].split()[0]))
            except:
                pass
        if "packet loss" in l:
            loss = int(l.split("%")[0].split()[-1])

    return rtt, loss

def score(latency, loss):
    score = 100
    if latency > 100: score -= 30
    if latency > 200: score -= 50
    if loss > 2: score -= 20
    if loss > 5: score -= 40
    return max(score, 0)

print("=== NETWORK INTELLIGENCE ENGINE ===")
rtt, loss = ping_test()

if not rtt:
    print("Network unreachable")
    exit(1)

avg = round(statistics.mean(rtt), 2)
jit = round(statistics.stdev(rtt), 2) if len(rtt) > 1 else 0
net_score = score(avg, loss)

print(f"Average Ping : {avg} ms")
print(f"Jitter       : {jit} ms")
print(f"Packet Loss  : {loss}%")
print(f"Network Score: {net_score}/100")

print("\n--- STATUS ---")
if net_score >= 80:
    print("EXCELLENT 🟢")
elif net_score >= 60:
    print("GOOD 🟡")
elif net_score >= 40:
    print("POOR 🔴")
else:
    print("CRITICAL ⚠️")

print("\n--- RECOMMENDATION ---")
if avg > 100:
    print("- Ganti DNS / pindah jaringan")
if loss > 3:
    print("- Sinyal lemah atau interferensi")
if jit > 20:
    print("- Jaringan tidak stabil")
print("- Matikan aplikasi berat")
