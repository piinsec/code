#!/bin/bash

domain=$1
RED="\033[1;31m"
RESET="\033[0m"

info_path=$domain/info 
subdomain_path=$doamin/subdomains 
screenshot_path=$doamin/screenshot 

if [ ! -d "$doamin" ]; then
	mkdir $domain 
fi

if [ ! -d "$info_path" ]; then
	mkdir $info_path 
fi

if [ ! -d "$subdomain_path" ]; then
	mkdir $subdomain_path 
fi

if [ ! -d "$screenshot_path" ]; then
	mkdir $screenshot_path 
fi

echo -e "${RED} [+] Checkin'who it is ... ${RESET}"
whois $1 > $info_path/whois.txt

echo -e "${RED} [+] Launching subfinding ... ${RESET}"
subfinder -d $domain > $subdomain_path/found.txt

echo -e "${RED} [+] Running assetfinder ... ${RESET}"
assetfinder $domain | grep $domain >> $ subdomain_path/found.txt

echo -e "${RED} [+] Checkin' what's alive ... ${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt