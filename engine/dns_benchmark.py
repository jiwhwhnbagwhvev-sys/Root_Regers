#!/usr/bin/env python3
# =====================================================
# DNS BENCHMARK ENGINE — ROOT_REGERS
# Real DNS latency & reliability test
# =====================================================

import socket
import time
import statistics
from datetime import datetime

DNS_SERVERS = {
    "Google DNS": "8.8.8.8",
    "Cloudflare": "1.1.1.1",
    "Quad9": "9.9.9.9",
    "OpenDNS": "208.67.222.222"
}

TEST_DOMAIN = "google.com"
PORT = 53
TIMEOUT = 2
REPEAT = 10

LOG_FILE = "/data/local/tmp/dns_benchmark.log"

def log(msg):
    with open(LOG_FILE, "a") as f:
        f.write(f"[{datetime.now()}] {msg}\n")

def build_dns_query(domain):
    packet = b'\xaa\xaa'  # Transaction ID
    packet += b'\x01\x00' # Flags
    packet += b'\x00\x01' # Questions
    packet += b'\x00\x00\x00\x00\x00\x00'

    for part in domain.split('.'):
        packet += bytes([len(part)]) + part.encode()
    packet += b'\x00'
    packet += b'\x00\x01'  # Type A
    packet += b'\x00\x01'  # Class IN
    return packet

def test_dns(server_ip):
    times = []
    success = 0

    for i in range(REPEAT):
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            sock.settimeout(TIMEOUT)
            query = build_dns_query(TEST_DOMAIN)

            start = time.time()
            sock.sendto(query, (server_ip, PORT))
            sock.recvfrom(512)
            end = time.time()

            latency = (end - start) * 1000
            times.append(latency)
            success += 1
            sock.close()

        except Exception:
            pass

    return times, success

def score(avg, success_rate):
    score = 100
    if avg > 100: score -= 25
    if avg > 200: score -= 40
    if success_rate < 100: score -= (100 - success_rate)
    return max(score, 0)

def grade(score):
    if score >= 85: return "EXCELLENT"
    if score >= 70: return "GOOD"
    if score >= 50: return "FAIR"
    if score >= 30: return "POOR"
    return "CRITICAL"

def banner():
    print("====================================")
    print(" DNS BENCHMARK ENGINE")
    print(" Real DNS Performance Test")
    print("====================================\n")

def main():
    banner()
    results = {}

    for name, ip in DNS_SERVERS.items():
        print(f"[+] Testing {name} ({ip})")
        times, success = test_dns(ip)

        if times:
            avg = round(statistics.mean(times), 2)
            jit = round(statistics.stdev(times), 2) if len(times) > 1 else 0
        else:
            avg = 0
            jit = 0

        success_rate = int((success / REPEAT) * 100)
        net_score = score(avg, success_rate)

        results[name] = {
            "ip": ip,
            "avg_ms": avg,
            "jitter_ms": jit,
            "success_rate": success_rate,
            "score": net_score,
            "grade": grade(net_score)
        }

        print(f"    Avg     : {avg} ms")
        print(f"    Jitter  : {jit} ms")
        print(f"    Success : {success_rate}%")
        print(f"    Score   : {net_score} ({grade(net_score)})\n")

        log(f"{name} avg={avg} jitter={jit} success={success_rate}% score={net_score}")
        time.sleep(0.3)

    print("=== BEST DNS ===")
    best = max(results.items(), key=lambda x: x[1]["score"])
    print(f"{best[0]} ({best[1]['ip']})")

    print("\nLog saved:", LOG_FILE)
    input("\nENTER untuk keluar...")

if __name__ == "__main__":
    main()
