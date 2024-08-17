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

# Get Terminal Dimensions
get_terminal_width() {
    tput cols
}

# Center Text Function
center_text() {
    local text="$1"
    local width="$2"
    printf "%*s\n" $(( (width + ${#text}) / 2 )) "$text"
}

# Function: Show Header
show_header() {
    local width=$(get_terminal_width)
    center_text "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}" $width
    center_text "${MAGENTA}                           ชุนชน เจฟ.เจฟ SSH V2RAY                          ${NC}" $width
    center_text "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}" $width
}

# Function: Show System Info
show_system_info() {
    local width=$(get_terminal_width)
    echo -e "${WHITE}ระบบปฏิบัติการ${NC}           : Ubuntu 20.04.6 LTS" | center_text $width
    echo -e "${WHITE}เคอร์เนล${NC}                : 5.4.0-192-generic" | center_text $width
    echo -e "${WHITE}RAM ใช้งาน${NC}              : 11.76%" | center_text $width
    echo -e "${WHITE}โหลด CPU${NC}               : 11.8%" | center_text $width
    echo -e "${WHITE}เวลาใช้งานเซิร์ฟเวอร์${NC}     : up 2 minutes" | center_text $width
    echo -e "${WHITE}IP VPS${NC}                 : 103.230.121.56" | center_text $width
    echo -e "${WHITE}โดเมน${NC}                  : th.nurul.cloud" | center_text $width
    echo -e "${WHITE}สถานะโดเมน${NC}            : ตลอดชีพ" | center_text $width
    echo -e "${WHITE}ชื่อผู้ใช้งาน${NC}           : Koala VPN | center_text $width
}

# Function: Show Menu
show_menu() {
    local width=$(get_terminal_width)
    center_text "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}" $width
    center_text "${CYAN}1. สร้างชื่อผู้ใช้ SSH OVPN           8. ข้อมูลฮาร์ดแวร์ VPS${NC}" $width
    center_text "${CYAN}2. สร้างชื่อผู้ใช้ VMESS              9. ข้อมูลโค้ด VPS${NC}" $width
    center_text "${CYAN}3. สร้างชื่อผู้ใช้ VLESS              10. ทดสอบความเร็ว${NC}" $width
    center_text "${CYAN}4. จัดการ TROJAN                     11. เปลี่ยนโดเมน${NC}" $width
    center_text "${CYAN}5. จัดการ SHADOWSOCKS                12. เปลี่ยนแบรนด์เนอร์${NC}" $width
    center_text "${CYAN}6. ระบบที่กำลังทำงาน                13. รีสตาร์ทบริการ${NC}" $width
    center_text "${CYAN}7. สำรองและกู้คืน                   14. รีสตาร์ทเซิร์ฟเวอร์${NC}" $width
    center_text "${CYAN}15. เปลี่ยน DNS                     16. ตรวจสอบ NETFLIX${NC}" $width
    center_text "${CYAN}17. SWAP RAM                        18. เปลี่ยน XRAYCORE${NC}" $width
    center_text "${CYAN}19. ติดตั้ง UDP                      20. ติดตั้ง BBRPLUS${NC}" $width
    center_text "${BLUE}═══════════════════════════════════════════════════════════════════════════════${NC}" $width
    echo -e "กรุณาเลือกคำสั่งจากเมนู [1-20]: " | center_text $width
}

# Function: Create SSH OVPN User
create_ssh_ovpn_user() {
    echo "Creating SSH OVPN user..."
    # Add the actual command to create SSH OVPN user
}

# Function: Create VMESS User
create_vmess_user() {
    echo "Creating VMESS user..."
    # Add the actual command to create VMESS user
}

# Function: Create VLESS User
create_vless_user() {
    echo "Creating VLESS user..."
    # Add the actual command to create VLESS user
}

# Add similar functions for other options...

# Main Menu Loop
while true; do
    clear
    show_header
    show_system_info
    show_menu
    read -p "กรอกคำสั่งของคุณ: " choice

    case $choice in
        1) create_ssh_ovpn_user ;;
        2) create_vmess_user ;;
        3) create_vless_user ;;
        # Add cases for other options and call the corresponding functions
        20) echo "Installing BBRPLUS..." ;;
        *) echo -e "${RED}Invalid option!${NC}" ;;
    esac
done
