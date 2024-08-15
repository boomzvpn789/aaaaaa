#!/bin/bash

# ตรวจสอบสิทธิ์การเข้าถึง root
if [ "$(id -u)" -ne "0" ]; then
    echo "โปรดรันสคริปต์นี้ด้วยสิทธิ์ root"
    exit 1
fi

# อัพเดตแพ็กเกจ
echo "อัพเดตแพ็กเกจ..."
apt update && apt upgrade -y

# ติดตั้ง OpenSSH Server
echo "ติดตั้ง OpenSSH Server..."
apt install -y openssh-server

# ตรวจสอบสถานะของ SSH
echo "ตรวจสอบสถานะของ SSH..."
systemctl status ssh

# เปิดใช้งาน SSH ให้เริ่มทำงานอัตโนมัติ
echo "เปิดใช้งาน SSH ให้เริ่มทำงานอัตโนมัติ..."
systemctl enable ssh

# เริ่มต้นบริการ SSH
echo "เริ่มต้นบริการ SSH..."
systemctl start ssh

# ตั้งค่า firewall ให้อนุญาตการเชื่อมต่อ SSH
echo "ตั้งค่า firewall ให้อนุญาตการเชื่อมต่อ SSH..."
ufw allow OpenSSH
ufw --force enable

# ติดตั้ง Dependencies
echo "ติดตั้ง Dependencies..."
apt install -y wget unzip

# ติดตั้ง V2Ray
echo "ติดตั้ง V2Ray..."
wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-amd64.zip -O /tmp/v2ray.zip
unzip /tmp/v2ray.zip -d /usr/local/v2ray
chmod +x /usr/local/v2ray/v2ray /usr/local/v2ray/v2ctl
ln -s /usr/local/v2ray/v2ray /usr/bin/v2ray
ln -s /usr/local/v2ray/v2ctl /usr/bin/v2ctl

# สร้างไฟล์คอนฟิก V2Ray
echo "สร้างไฟล์คอนฟิก V2Ray..."
cat <<EOF > /usr/local/v2ray/config.json
{
    "inbounds": [
        {
            "port": 443,
            "listen": "0.0.0.0",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "YOUR_UUID",
                        "alterId": 64
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/your-path"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {}
        }
    ]
}
EOF

# เปลี่ยน YOUR_UUID เป็น UUID ที่สร้างใหม่
UUID=$(cat /proc/sys/kernel/random/uuid)
sed -i "s/YOUR_UUID/$UUID/" /usr/local/v2ray/config.json

# สร้างไฟล์บริการ Systemd สำหรับ V2Ray
echo "สร้างไฟล์บริการ Systemd สำหรับ V2Ray..."
cat <<EOF > /etc/systemd/system/v2ray.service
[Unit]
Description=V2Ray Service
After=network.target

[Service]
ExecStart=/usr/local/v2ray/v2ray -config /usr/local/v2ray/config.json
Restart=on-failure
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

# เริ่มต้น V2Ray และเปิดใช้งานให้เริ่มทำงานอัตโนมัติ
echo "เริ่มต้น V2Ray และเปิดใช้งานให้เริ่มทำงานอัตโนมัติ..."
systemctl daemon-reload
systemctl start v2ray
systemctl enable v2ray

# ติดตั้ง x-ui
echo "ติดตั้ง x-ui..."
wget https://github.com/sprov065/x-ui/releases/download/v0.0.0/x-ui-linux-amd64.zip -O /tmp/x-ui.zip
unzip /tmp/x-ui.zip -d /usr/local/x-ui
chmod +x /usr/local/x-ui/x-ui
ln -s /usr/local/x-ui/x-ui /usr/bin/x-ui

# สร้างไฟล์คอนฟิก x-ui
echo "สร้างไฟล์คอนฟิก x-ui..."
cat <<EOF > /usr/local/x-ui/x-ui.json
{
    "port": 8080,
    "listen": "0.0.0.0",
    "log_level": "info",
    "api": {
        "username": "admin",
        "password": "admin"
    },
    "v2ray_config": "/usr/local/v2ray/config.json"
}
EOF

# สร้างไฟล์บริการ Systemd สำหรับ x-ui
echo "สร้างไฟล์บริการ Systemd สำหรับ x-ui..."
cat <<EOF > /etc/systemd/system/x-ui.service
[Unit]
Description=x-ui Service
After=network.target

[Service]
ExecStart=/usr/local/x-ui/x-ui -config /usr/local/x-ui/x-ui.json
Restart=on-failure
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

# เริ่มต้น x-ui และเปิดใช้งานให้เริ่มทำงานอัตโนมัติ
echo "เริ่มต้น x-ui และเปิดใช้งานให้เริ่มทำงานอัตโนมัติ..."
systemctl daemon-reload
systemctl start x-ui
systemctl enable x-ui

# ข้อมูลการติดตั้ง
echo "V2Ray และ x-ui ได้รับการติดตั้งและเริ่มต้นเรียบร้อยแล้ว"
echo "ใช้พอร์ต 8080 เพื่อเข้าถึง x-ui และจัดการคอนฟิก V2Ray"
echo "UUID ของคุณคือ $BOOM"
