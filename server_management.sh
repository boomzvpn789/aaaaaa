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
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}                           ขุมชนจัดการ EKROMVPN SSH                            ${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}"
}

# Function: Show System Info
show_system_info() {
    echo -e "${WHITE}ระบบปฏิบัติการ${NC}     : Ubuntu 20.04.6 LTS"
    echo -e "${WHITE}เคอร์เนล${NC}          : 5.4.0-192-generic"
    echo -e "${WHITE}RAM ใช้งาน${NC}        : 11.76%"
    echo -e "${WHITE}โหลด CPU${NC}         : 11.8%"
    echo -e "${WHITE}เวลาใช้งานเซิร์ฟเวอร์${NC} : up 2 minutes"
    echo -e "${WHITE}IP VPS${NC}           : 103.230.121.56"
    echo -e "${WHITE}โดเมน${NC}            : th.nurul.cloud"
    echo -e "${WHITE}สถานะโดเมน${NC}      : ตลอดชีพ"
    echo -e "${WHITE}ชื่อผู้ใช้งาน${NC}     : EKROMVPN SSH AIO"
}

# Function: Show Menu
show_menu() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}1. สร้างชื่อผู้ใช้ SSH OVPN           8. ข้อมูลฮาร์ดแวร์ VPS${NC}"
    echo -e "${CYAN}2. สร้างชื่อผู้ใช้ VMESS              9. ข้อมูลโค้ด VPS${NC}"
    echo -e "${CYAN}3. สร้างชื่อผู้ใช้ VLESS              10. ทดสอบความเร็ว${NC}"
    echo -e "${CYAN}4. จัดการ TROJAN                 11. เปลี่ยนโดเมน${NC}"
    echo -e "${CYAN}5. จัดการ SHADOWSOCKS            12. เปลี่ยนแบรนด์เนอร์${NC}"
    echo -e "${CYAN}6. ระบบที่กำลังทำงาน                13. รีสตาร์ทบริการ${NC}"
    echo -e "${CYAN}7. สำรองและกู้คืน                   14. รีสตาร์ทเซิร์ฟเวอร์${NC}"
    echo -e "${CYAN}15. เปลี่ยน DNS                   16. ตรวจสอบ NETFLIX${NC}"
    echo -e "${CYAN}17. SWAP RAM                    18. เปลี่ยน XRAYCORE${NC}"
    echo -e "${CYAN}19. ติดตั้ง UDP                    20. ติดตั้ง BBRPLUS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "กรุณาเลือกคำสั่งเลือกจากเมนู [1-20]: "
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
        # Add corresponding functions for other options here...
        20) echo "Option 20 selected." ;;
        *) echo -e "${RED}Invalid option!${NC}" ;;
    esac
done
