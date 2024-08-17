#!/bin/bash

# ===========================
# Color Definitions
# ===========================
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ===========================
# Function: Install OpenVPN
# ===========================
install_openvpn() {
    echo -e "${BLUE}Installing OpenVPN...${NC}"
    sudo apt update
    sudo apt install -y openvpn easy-rsa
    make-cadir ~/openvpn-ca
    cd ~/openvpn-ca
    # Additional OpenVPN configuration steps here...
    sudo systemctl start openvpn@server
    sudo systemctl enable openvpn@server
    echo -e "${GREEN}OpenVPN installed and configured.${NC}"
}

# ===========================
# Function: Install V2Ray
# ===========================
install_v2ray() {
    echo -e "${BLUE}Installing V2Ray...${NC}"
    bash <(curl -L -s https://install.direct/go.sh)
    echo -e "${GREEN}V2Ray installed.${NC}"
}

# ===========================
# Function: Install WebSocket with SSL
# ===========================
install_websocket() {
    echo -e "${BLUE}Installing WebSocket...${NC}"
    sudo apt install -y nodejs npm
    sudo tee /usr/local/bin/websocket_server.js <<EOF
const WebSocket = require('ws');
const https = require('https');
const fs = require('fs');

const server = https.createServer({
    key: fs.readFileSync('/etc/ssl/private/your_key.pem'),
    cert: fs.readFileSync('/etc/ssl/certs/your_cert.pem')
});

const wss = new WebSocket.Server({ server });

wss.on('connection', ws => {
    ws.on('message', message => {
        console.log('received: %s', message);
        ws.send('Hello! Message received.');
    });
});

const PORT = 8443;
server.listen(PORT, () => {
    console.log(\`WebSocket server running on port \${PORT}\`);
});
EOF
    sudo chmod +x /usr/local/bin/websocket_server.js
    nohup node /usr/local/bin/websocket_server.js &
    echo -e "${GREEN}WebSocket installed and running on port 8443.${NC}"
}

# ===========================
# Function: Install Slow DNS
# ===========================
install_dns() {
    echo -e "${BLUE}Installing Slow DNS...${NC}"
    sudo apt install -y dnsmasq
    sudo tee /etc/dnsmasq.conf <<EOF
port=53
query_log
log-queries
log-dhcp
EOF
    sudo systemctl restart dnsmasq
    sudo systemctl enable dnsmasq
    echo -e "${GREEN}Slow DNS configured on port 53.${NC}"
}

# ===========================
# Function: Create User with Expiry
# ===========================
create_user() {
    read -p "Enter username: " username
    read -p "Enter password: " password
    read -p "Enter number of days until expiry: " days
    sudo useradd -m -e $(date -d "$days days" +"%Y-%m-%d") -s /bin/false "$username"
    echo "$username:$password" | sudo chpasswd
    echo -e "${GREEN}User $username created and will expire in $days days.${NC}"
}

# ===========================
# Function: Remove OpenVPN
# ===========================
remove_openvpn() {
    echo -e "${RED}Removing OpenVPN...${NC}"
    sudo systemctl stop openvpn@server
    sudo systemctl disable openvpn@server
    sudo apt remove --purge -y openvpn
    sudo rm -rf /etc/openvpn
    echo -e "${GREEN}OpenVPN removed.${NC}"
}

# ===========================
# Function: Remove V2Ray
# ===========================
remove_v2ray() {
    echo -e "${RED}Removing V2Ray...${NC}"
    sudo systemctl stop v2ray
    sudo systemctl disable v2ray
    sudo apt remove --purge -y v2ray
    sudo rm -rf /etc/v2ray
    echo -e "${GREEN}V2Ray removed.${NC}"
}

# ===========================
# Function: Remove WebSocket
# ===========================
remove_websocket() {
    echo -e "${RED}Removing WebSocket...${NC}"
    sudo pkill -f websocket_server.js
    sudo rm -f /usr/local/bin/websocket_server.js
    sudo apt remove --purge -y nodejs npm
    echo -e "${GREEN}WebSocket removed.${NC}"
}

# ===========================
# Function: Remove Slow DNS
# ===========================
remove_dns() {
    echo -e "${RED}Removing Slow DNS...${NC}"
    sudo systemctl stop dnsmasq
    sudo systemctl disable dnsmasq
    sudo apt remove --purge -y dnsmasq
    sudo rm -rf /etc/dnsmasq.conf /var/lib/dnsmasq
    echo -e "${GREEN}Slow DNS removed.${NC}"
}

# ===========================
# Function: Remove All
# ===========================
remove_all() {
    echo -e "${RED}Removing all installed services and scripts...${NC}"
    remove_openvpn
    remove_v2ray
    remove_websocket
    remove_dns
    echo -e "${GREEN}All services and scripts removed.${NC}"
}

# ===========================
# Function: Show Menu
# ===========================
show_menu() {
    clear
    echo -e "${YELLOW}=========================================${NC}"
    echo -e "${YELLOW}       Server Setup and Management       ${NC}"
    echo -e "${YELLOW}=========================================${NC}"
    echo -e "${BLUE}1.${NC} ${GREEN}Install OpenVPN${NC}"
    echo -e "${BLUE}2.${NC} ${GREEN}Install V2Ray${NC}"
    echo -e "${BLUE}3.${NC} ${GREEN}Install WebSocket${NC}"
    echo -e "${BLUE}4.${NC} ${GREEN}Install Slow DNS${NC}"
    echo -e "${BLUE}5.${NC} ${GREEN}Create User with Expiry${NC}"
    echo -e "${BLUE}6.${NC} ${RED}Remove OpenVPN${NC}"
    echo -e "${BLUE}7.${NC} ${RED}Remove V2Ray${NC}"
    echo -e "${BLUE}8.${NC} ${RED}Remove WebSocket${NC}"
    echo -e "${BLUE}9.${NC} ${RED}Remove Slow DNS${NC}"
    echo -e "${BLUE}10.${NC} ${RED}Remove All${NC}"
    echo -e "${BLUE}11.${NC} ${YELLOW}Exit${NC}"
    echo -e "${YELLOW}=========================================${NC}"
}

# ===========================
# Main Menu Loop
# ===========================
while true; do
    show_menu
    read -p "Enter your choice [1-11]: " choice

    case $choice in
        1) install_openvpn ;;
        2) install_v2ray ;;
        3) install_websocket ;;
        4) install_dns ;;
        5) create_user ;;
        6) remove_openvpn ;;
        7) remove_v2ray ;;
        8) remove_websocket ;;
        9) remove_dns ;;
        10) remove_all ;;
        11) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Please select a valid option.${NC}" ;;
    esac
done
