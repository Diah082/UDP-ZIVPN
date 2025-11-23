#!/bin/bash
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
    FILE="install-amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    FILE="install-arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

wget -O install "https://github.com/diah082/udp-zivpn/releases/latest/download/$FILE"
chmod +x install
./install

