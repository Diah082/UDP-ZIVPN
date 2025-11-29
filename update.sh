#!/bin/bash

set -euo pipefail

# ======= WARNA =======
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[36m"
RESET="\e[0m"

# ======= INFO =======
echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}        ZIVPN MENU INSTALLER            ${RESET}"
echo -e "${BLUE}========================================${RESET}"
echo ""

# ======= DETEKSI ARCH =======
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)
        FILE="menu-amd64"
        ;;
    aarch64|arm64)
        FILE="menu-arm64"
        ;;
    *)
        echo -e "${RED}❌ Unsupported architecture: $ARCH${RESET}"
        exit 1
        ;;
esac

echo -e "${YELLOW}✔ Architecture detected : $ARCH${RESET}"
echo -e "${YELLOW}✔ Using binary          : $FILE${RESET}"
echo ""

# ======= DESTINATION =======
DEST="/usr/local/bin/menu"

# Backup jika sudah ada
if [[ -f "$DEST" ]]; then
    echo -e "${YELLOW}🔄 Found existing menu, creating backup...${RESET}"
    cp "$DEST" "${DEST}.backup_$(date +%Y%m%d%H%M)"
fi

# ======= DOWNLOAD BINARY =======
URL="https://github.com/diah082/udp-zivpn/releases/latest/download/$FILE"

echo -e "${YELLOW}⬇ Downloading $FILE ...${RESET}"

# Retry 3x jika gagal
for attempt in {1..3}; do
    if wget -q --show-progress -O "$DEST" "$URL"; then
        break
    else
        echo -e "${RED}⚠ Download failed (attempt $attempt)...${RESET}"
        sleep 2
    fi

    if [[ $attempt -eq 3 ]]; then
        echo -e "${RED}❌ Failed to download file after 3 attempts.${RESET}"
        exit 1
    fi
done

# ======= CEK FILE VALID =======
if [[ ! -s "$DEST" ]]; then
    echo -e "${RED}❌ Downloaded file is empty or corrupted.${RESET}"
    exit 1
fi

chmod +x "$DEST"

echo ""
echo -e "${GREEN}========================================${RESET}"
echo -e "${GREEN}     ✔ INSTALLATION SUCCESSFUL!        ${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Command available : ${RESET} menu"
echo ""
