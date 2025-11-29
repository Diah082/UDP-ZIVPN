#!/bin/bash
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
    FILE="menu-amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    FILE="menu-arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

wget -O /usr/local/bin/menu "https://github.com/diah082/udp-zivpn/releases/latest/download/$FILE"
chmod +x /usr/local/bin/menu
