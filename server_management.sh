#!/bin/bash

# Color Definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function: Show Header
show_header() {
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}                           ชุนชน เจฟ.เจฟ SSH V2RAY                          ${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════════════════${NC}"
}

# Function: Show System Info
show_system_info() {
    echo -e "${WHITE}ระบบปฏิบัติการ${NC}                : Ubuntu 20.04.6 LTS"
    echo -e "${WHITE}เคอร์เนล${NC}                     : 5.4.0-192-generic"
    echo -e "${WHITE}RAM ใช้งาน${NC}                   : 11.76%"
    echo -e "${WHITE}โหลด CPU${NC}                    : 11.8%"
    echo -e "${WHITE}เวลาใช้งานเซิร์ฟเวอร์${NC}        : up 2 minutes"
    echo -e "${WHITE}IP VPS${NC}                      : 103.230.121.56"
    echo -e "${WHITE}โดเมน${NC}                       : th.nurul.cloud"
    echo -e "${WHITE}สถานะโดเมน${NC}                 : ตลอดชีพ"
    echo -e "${WHITE}ชื่อผู้ใช้งาน${NC}                : EKROMVPN SSH AIO"
}

# Function: Show Menu
show_menu() {
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}         ███████╗██╗░░██╗███████╗███████╗██╗░░░██╗██╗███████╗███████╗${NC}"
    echo -e "${CYAN}         ██╔════╝██║░░██║██╔════╝██╔════╝██║░░░██║██║██╔════╝██╔════╝${NC}"
    echo -e "${CYAN}         █████╗░███████║█████╗░░█████╗░░██║░░░██║██║█████╗░░█████╗░${NC}"
    echo -e "${CYAN}         ██╔══╝░██╔══██║██╔══╝░░██╔══╝░░██║░░░██║██║██╔══╝░░██╔══╝░${NC}"
    echo -e "${CYAN}         ███████╗██║░░██║███████╗███████╗╚██████╔╝██║███████╗███████╗${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}            [1] สร้างชื่อผู้ใช้ SSH OVPN      ${YELLOW}[8] ข้อมูลฮาร์ดแวร์ VPS${NC}"
    echo -e "${YELLOW}            [2] สร้างชื่อผู้ใช้ VMESS         ${YELLOW}[9] ข้อมูลโค้ด VPS${NC}"
    echo -e "${YELLOW}            [3] สร้างชื่อผู้ใช้ VLESS         ${YELLOW}[10] ทดสอบความเร็ว${NC}"
    echo -e "${YELLOW}            [4] จัดการ TROJAN              ${YELLOW}[11] เปลี่ยนโดเมน${NC}"
    echo -e "${YELLOW}            [5] จัดการ SHADOWSOCKS         ${YELLOW}[12] เปลี่ยนแบรนด์เนอร์${NC}"
    echo -e "${YELLOW}            [6] ระบบที่กำลังทำงาน           ${YELLOW}[13] รีสตาร์ทบริการ${NC}"
    echo -e "${YELLOW}            [7] สำรองและกู้คืน              ${YELLOW}[14] รีสตาร์ทเซิร์ฟเวอร์${NC}"
    echo -e "${YELLOW}            [15] เปลี่ยน DNS              ${YELLOW}[16] ตรวจสอบ NETFLIX${NC}"
    echo -e "${YELLOW}            [17] SWAP RAM                 ${YELLOW}[18] เปลี่ยน XRAYCORE${NC}"
    echo -e "${YELLOW}            [19] ติดตั้ง UDP               ${YELLOW}[20] ติดตั้ง BBRPLUS${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "กรุณาเลือกคำสั่งจากเมนู [1-20]: "
}

# Main Menu Loop
while true; do
    clear
    show_header
    show_system_info
    show_menu
    read -p "กรอกคำสั่งของคุณ: " choice

    case $choice in
        1) echo "Option 1 selected." ;;
        2) echo "Option 2 selected." ;;
        3) echo "Option 3 selected." ;;
        4) echo "Option 4 selected." ;;
        5) echo "Option 5 selected." ;;
        6) echo "Option 6 selected." ;;
        7) echo "Option 7 selected." ;;
        8) echo "Option 8 selected." ;;
        9) echo "Option 9 selected." ;;
        10) echo "Option 10 selected." ;;
        11) echo "Option 11 selected." ;;
        12) echo "Option 12 selected." ;;
        13) echo "Option 13 selected." ;;
        14) echo "Option 14 selected." ;;
        15) echo "Option 15 selected." ;;
        16) echo "Option 16 selected." ;;
        17) echo "Option 17 selected." ;;
        18) echo "Option 18 selected." ;;
        19) echo "Option 19 selected." ;;
        20) echo "Option 20 selected." ;;
        *) echo -e "${RED}Invalid option!${NC}" ;;
    esac
done
