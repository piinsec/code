import os


def recon(ip):
    os.system(f"nmap -A -sC -sV -Pn {ip} -v")


recon(input("Enter ip to scan : "))
