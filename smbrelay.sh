#!/usr/bin/env bash

# By @m4lal0
# Modded by ITmustang

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Blink='\033[5m'         # Blink
Color_Off='\033[0m'     # Text Reset

# Light
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan
LWhite='\033[0;90m'     # Ligth White

# Dark
DGray='\033[2;37m'      # Dark Gray
DRed='\033[2;91m'       # Dark Red
DGreen='\033[2;92m'     # Dark Green
DYellow='\033[2;93m'    # Dark Yellow
DBlue='\033[2;94m'      # Dark Blue
DPurple='\033[2;95m'    # Dark Purple
DCyan='\033[2;96m'      # Dark Cyan
DWhite='\033[2;90m'     # Dark White

# Bold
BBlack='\033[1;30m'     # Bold Black
BRed='\033[1;31m'       # Bold Red
BGreen='\033[1;32m'     # Bold Green
BYellow='\033[1;33m'    # Bold Yellow
BBlue='\033[1;34m'      # Bold Blue
BPurple='\033[1;35m'    # Bold Purple
BCyan='\033[1;36m'      # Bold Cyan
BWhite='\033[1;37m'     # Bold White

# Italics
IBlack='\033[3;30m'     # Italic Black
IGray='\033[3;90m'      # Italic Gray
IRed='\033[3;31m'       # Italic Red
IGreen='\033[3;32m'     # Italic Green
IYellow='\033[3;33m'    # Italic Yellow
IBlue='\033[3;34m'      # Italic Blue
IPurple='\033[3;35m'    # Italic Purple
ICyan='\033[3;36m'      # Italic Cyan
IWhite='\033[3;37m'     # Italic White

# Underline
UBlack='\033[4;30m'     # Underline Black
URed='\033[4;31m'       # Underline Red
UGreen='\033[4;32m'     # Underline Green
UYellow='\033[4;33m'    # Underline Yellow
UBlue='\033[4;34m'      # Underline Blue
UPurple='\033[4;35m'    # Underline Purple
UCyan='\033[4;36m'      # Underline Cyan
UWhite='\033[4;37m'     # Underline White

# Background
On_Black='\033[40m'     # Background Black
On_Red='\033[41m'       # Background Red
On_Green='\033[42m'     # Background Green
On_Yellow='\033[43m'    # Background Yellow
On_Blue='\033[44m'      # Background Blue
On_Purple='\033[45m'    # Background Purple
On_Cyan='\033[46m'      # Background Cyan
On_White='\033[47m'     # Background White

export DEBIAN_FRONTEND=noninteractive
VERSION=1.0.2

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Exiting...${Color_Off}"
    stopped
    exit 0
}

function helpPanel(){
    echo -e "\n${BWhite}Tool made in Bash for automating the Samba Relay Attack.${Color_Off}\n"
    echo -e "${BWhite}USAGE: \n\t ${BGreen}./smbrelay.sh${Color_Off}\n"
    echo -e "${BWhite}OPTIONS:${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-i , --install${LBlue}] \t${BPurple}Tool installation.${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-u , --update${LBlue}] \t${BPurple}Tool update.${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-h , --help${LBlue}] \t\t${BPurple}Show this help message.${Color_Off}\n"
    tput cnorm; exit 0
}

function banner(){
    clear
    echo -e "\t${BYellow} ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄ ▄▄   ▄▄ "
    echo -e "\t█       █  █▄█  █  ▄    █   ▄  █ █       █   █   █      █  █ █  █"
    echo -e "\t█  ▄▄▄▄▄█       █ █▄█   █  █ █ █ █    ▄▄▄█   █   █  ▄   █  █▄█  █"
    echo -e "\t█ █▄▄▄▄▄█       █       █   █▄▄█▄█   █▄▄▄█   █   █ █▄█  █       █"
    echo -e "\t█▄▄▄▄▄  █       █  ▄   ██    ▄▄  █    ▄▄▄█   █▄▄▄█      █▄     ▄█"
    echo -e "\t ▄▄▄▄▄█ █ ██▄██ █ █▄█   █   █  █ █   █▄▄▄█       █  ▄   █ █   █  "
    echo -e "\t█▄▄▄▄▄▄▄█▄█   █▄█▄▄▄▄▄▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄█ █▄▄█ █▄▄▄█   ${Color_Off}${ICyan}By @m4lal0${Color_Off}"
    echo -e "\t                   ${On_Yellow}${BBlack}  SMB Relay Attack Script  ${Color_Off}\n"
}

function checkUpdate(){
    GIT=$(curl --silent https://github.com/ITmustang/smbrelay/blob/main/smbrelay.sh | grep 'VERSION=' | cut -d">" -f2 | cut -d"<" -f1 | cut -d"=" -f 2)
    if [[ "$GIT" == "$VERSION" || -z $GIT ]]; then
        echo -e "${BGreen}[✔]${Color_Off} ${BGreen}The current version is the latest one.${Color_Off}\n"
        tput cnorm; exit 0
    else
        echo -e "${Yellow}[*]${Color_Off} ${IWhite}Update available${Color_Off}"
        echo -e "${Yellow}[*]${Color_Off} ${IWhite}Upgrading the version${Color_Off} ${BWhite}$VERSION${Color_Off} ${IWhite}to the${Color_Off} ${BWhite}$GIT${Color_Off}"
        update="1"
    fi
}

function installUpdate(){
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Installing updates...${Color_Off}"
    git clone https://github.com/ITmutstang/smbrelay &>/dev/null
    chmod +x smbrelay/smbrelay.sh && mv smbrelay/src/* src &>/dev/null
    mv smbrelay/smbrelay.sh . &>/dev/null
    if [ "$(echo $?)" == "0" ]; then
        echo -e "${BGreen}[ OK ]${Color_Off}"
    else
        echo -e "${BRed}[ FAIL ]${Color_Off}"
        tput cnorm && exit 1
    fi
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Cleaning...${Color_Off}"
    wait
    rm -rf smbrelay &>/dev/null
    if [ "$(echo $?)" == "0" ]; then
        echo -e "${BGreen}[ OK ]${Color_Off}"
    else
        echo -e "${BRed}[ FAIL ]${Color_Off}"
        tput cnorm && exit 1
    fi
    echo -e "\n${BGreen}[✔]${Color_Off} ${IGreen}Version updated to${Color_Off} ${BWhite}$GIT${Color_Off}\n"
    tput cnorm && exit 0
}

function update(){
    banner
    echo -e "\n${BBlue}[+]${Color_Off} ${BWhite}Version smbrelay: $VERSION${Color_Off}"
    echo -e "${BBlue}[+]${Color_Off} ${BWhite}Checking smbrelay update${Color_Off}"
    checkUpdate
    echo -e "\t${BWhite}$VERSION ${IWhite}Installed version${Color_Off}"
    echo -e "\t${BWhite}$GIT ${IWhite}Version in Git${Color_Off}\n"
    if [ "$update" != "1" ]; then
        tput cnorm && exit 0;
    else
        echo -e "${BBlue}[+]${Color_Off} ${BWhite}Need to upgrade!${Color_Off}"
        tput cnorm
        echo -en "${BPurple}[?]${Color_Off} ${BCyan}Want to upgrade? (${BGreen}Y${BCyan}/${BRed}n${BCyan}):${Color_Off} " && read CONDITION
        tput civis
        case "$CONDITION" in
            n|N) echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}No updated, stays on version ${BWhite}$VERSION${Color_Off}\n" && tput cnorm && exit 0;;
            *) installUpdate;;
        esac
    fi
}

function install(){
    banner
    dependencies=(tmux responder rlwrap ncat python3 nishang perl python3-impacket shellter)
    echo -e "\n${LBlue}[${BBlue}+${LBlue}] ${BBlue}Checking required tools:${Color_Off}\n"
    for program in "${dependencies[@]}"; do
        echo -ne "${LBlue}[${BBlue}*${LBlue}] ${BWhite}Tool: $program...${Color_Off}"
        command -v $program > /dev/null 2>&1
        if [ "$(echo $?)" == "0" ]; then
            echo -e "${LBlue}($BGreen✔${LBlue})${Color_Off}"
        else
            echo -e "${LBlue}(${BRed}✘${LBlue})${Color_Off}"
            echo -en "${LBlue}[${BYellow}!${LBlue}] ${BYellow}Installing ${BGreen}$program...${Color_Off}"
            apt-get install $program -y > /dev/null 2>&1
            if [ "$(echo $?)" == "0" ]; then
                echo -e "${LBlue}($BGreen✔${LBlue})${Color_Off}"
            else
                echo -e "${LBlue}(${BRed}✘${LBlue})${Color_Off}"
                tput cnorm; exit 0
            fi
        fi; sleep 1
    done
    if [ ! -d ~/.config/terminator ]; then
        mkdir -p ~/.config/terminator 2>/dev/null
        cp src/config ~/.config/terminator 2>/dev/null
    else
        cp src/config ~/.config/terminator 2>/dev/null
    fi
    if [ -d images ]; then
        rm -rf images 2>/dev/null
    fi
    if [ -f README.md ]; then
        rm README.md 2>/dev/null
    fi
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BGreen}Run the script: ./smbrelay.sh${Color_Off}\n"
    tput cnorm; exit 0
}

function stopped(){
    rm -rf iface.txt .attack PS.ps1 target.txt host.txt > /dev/null 2>&1
    killall python3  > /dev/null 2>&1
    perl -pi -e "s[SMB = Off][SMB = On]g" /usr/share/responder/Responder.conf
    perl -pi -e "s[HTTP = Off][HTTP = On]g" /usr/share/responder/Responder.conf
    tput cnorm
}

if [ "$(id -u)" == "0" ]; then
    tput civis
    arg=""
    for arg; do
        delim=""
        case $arg in
            --help)		args="${args}-h";;
            --install)	args="${args}-i";;
            --update)   args="${args}-u";;
            --*)        args="${args}*";;
            *) [[ "${arg:0:1}" == "-" ]] || delim="\""
            args="${args}${delim}${arg}${delim} ";;
        esac
    done

    eval set -- $args
    while getopts "iuh" opt; do
        case $opt in
            i) install;;
            u) update;;
            h) helpPanel;;
            *) helpPanel;;
        esac
    done

    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BGreen}Starting SMBrelay...${Color_Off}"
    sleep 2
    terminator -l smbrelay
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Stopping SMBrelay...${Color_Off}\n"
    stopped
else
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}It is necessary to run the program as root!${Color_Off}\n"
fi
