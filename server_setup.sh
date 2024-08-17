#!/bin/bash

# ฟังก์ชันติดตั้ง OpenVPN
install_openvpn() {
    echo "Installing OpenVPN..."
    sudo apt update
    sudo apt install -y openvpn

    # ตั้งค่า OpenVPN
    sudo tee /etc/openvpn/server.conf <<EOF
port 1194
proto udp
dev tun

ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh.pem

server 10.8.0.0 255.255.255.0
ifconfig-pool-persist /var/lib/openvpn/ipp.txt

push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"

keepalive 10 120
cipher AES-256-CBC
auth SHA256

compress lz4
persist-key
persist-tun
status /var/log/openvpn-status.log
verb 3
EOF

    sudo systemctl start openvpn@server
    sudo systemctl enable openvpn@server
    echo "OpenVPN installed and configured."
}

# ฟังก์ชันเปลี่ยนพอร์ต SSH
change_ssh_port() {
    echo "Changing SSH port..."
    sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    echo "SSH port changed to 2222."
}

# ฟังก์ชันตั้งค่า WebSocket (WS) กับ SSL
setup_websocket() {
    echo "Setting up WebSocket with SSL..."
    sudo apt install -y nodejs npm

    # สร้างไฟล์เซิร์ฟเวอร์ WebSocket
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
    echo "WebSocket server with SSL set up on port 8443."
}

# ฟังก์ชันติดตั้งและตั้งค่า DNS Slow
setup_dns_slow() {
    echo "Setting up DNS Slow..."
    sudo apt install -y dnsmasq

    # ตั้งค่า dnsmasq
    sudo tee /etc/dnsmasq.conf <<EOF
port=53
query_log
log-queries
log-dhcp
EOF

    sudo systemctl restart dnsmasq
    sudo systemctl enable dnsmasq
    echo "DNS Slow configured on port 53."
}

# ฟังก์ชันติดตั้ง V2Ray
install_v2ray() {
    echo "Installing V2Ray..."
    sudo apt update
    sudo apt install -y curl

    # ดาวน์โหลดและติดตั้ง V2Ray
    bash <(curl -s -L https://git.io/v2ray.sh)
    sudo systemctl start v2ray
    sudo systemctl enable v2ray
    echo "V2Ray installed and configured."
}

# ฟังก์ชันสร้างผู้ใช้ใหม่และตั้งวันหมดอายุ
create_user() {
    read -p "Enter username: " username
    read -p "Enter expiration date (YYYY-MM-DD): " exp_date
    sudo adduser --expiredate "$exp_date" "$username"
    echo "User $username created with expiration date $exp_date."
}

# ฟังก์ชันแสดงวันหมดอายุของผู้ใช้
show_user_expiry() {
    read -p "Enter username to check expiration: " username
    exp_date=$(sudo chage -l "$username" | grep "Account expires" | cut -d: -f2)
    echo "User $username expires on $exp_date."
}

# ฟังก์ชันแสดงเมนู
show_menu() {
    clear
    echo "========================================="
    echo "          Server Setup Menu              "
    echo "========================================="
    echo "1. Install OpenVPN"
    echo "2. Change SSH Port"
    echo "3. Set Up WebSocket"
    echo "4. Set Up DNS"
    echo "5. Install V2Ray"
    echo "6. Create User"
    echo "7. Show User Expiration"
    echo "8. Exit Script"
    echo "========================================="
}

# เมนูหลัก
while true; do
    show_menu
    read -p "Enter your choice [1-8]: " choice

    case $choice in
        1) install_openvpn ;;
        2) change_ssh_port ;;
        3) setup_websocket ;;
        4) setup_dns_slow ;;
        5) install_v2ray ;;
        6) create_user ;;
        7) show_user_expiry ;;
        8) exit 0 ;;
        *) echo "Invalid choice. Please select a valid option." ;;
    esac
done
