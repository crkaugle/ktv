#!/bin/sh

# config v2ray
cat << EOF > /etc/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "level": 1,
                         "alterId": 64
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                "connectionReuse": false,
                "path": "/"
            }
            }
        }
    ],

    "outbounds": [
        {
            "protocol": "freedom"
        },
        {
            "protocol": "blackhole",
            "tag": "blocked"
        },
        {
            "protocol": "socks",
            "tag": "sockstor",
            "settings": {
                "servers": [
                    {
                        "address": "127.0.0.1",
                        "port": 8050
                    }
                ]
            }
        }
    ],

    "routing": {
        "rules": [
            {
                "type": "field",
                "outboundTag": "sockstor",
                "domain": [
                    "geosite:tor"
                ]
            },
            {
                "type": "field",
                "outboundTag": "blocked",
                "domain": [
                    "geosite:category-ads-all"
                ]
            }
        ]
    }
}		
EOF

# start tor and v2ray
nohup tor &
v2ray -config /etc/config.json
