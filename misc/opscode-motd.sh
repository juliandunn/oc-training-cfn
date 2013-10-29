#!/bin/bash
# System information script for Opscode servers
# v0.1 - Initial release: 2013-06-26 Sean Carolan

# Whoa, a double rainbow! What does it mean?
red='\033[1;31m'
green='\033[1;32m'
blue='\033[1;34m'
normal='\033[0m'
bg_white='\033[1;47m'

# System variables
MEMSIZE=$(awk '/MemTotal:/{MEM=($2/1024)} END {print int(MEM)}' /proc/meminfo)
PROCS=$(grep processor /proc/cpuinfo | wc -l)
IPADDR=$(ifconfig | grep -m1 "inet addr" | awk '{ print $2}')

# Set OS-specific variables
# CentOS and Red Hat - uses standard /etc/motd
if [ -f /etc/redhat-release ]; then
  DISTRIB_DESCRIPTION=$(cat /etc/redhat-release)
  MOTDFILE="/etc/motd"
# Amazon Linux - uses standard /etc/motd
elif [ -f /etc/system-release ]; then
  DISTRIB_DESCRIPTION=$(cat /etc/system-release)
  MOTDFILE="/etc/motd"
# Ubuntu - the extra settings ensure that the motd banner isn't wiped out by our motd training exercise
elif [ -f /etc/lsb-release ]; then
  source /etc/lsb-release
  MOTDFILE="/etc/motd.opscode"
  echo -e '#!/bin/sh\n[ -f /etc/motd.opscode ] && cat /etc/motd.opscode || true' > /etc/update-motd.d/98-opscode
  chmod +x /etc/update-motd.d/98-opscode
fi

echo -e "" > $MOTDFILE
echo -e "${bg_white}${red} _______________    ___   ${blue} ________  ${normal}                                          " >> $MOTDFILE
echo -e "${bg_white}${red}/               \\  /   \\  ${blue}/        \\ ${normal} ${blue}##########################################" >> $MOTDFILE
echo -e "${bg_white}${red}\\_______________/  \\___/  ${blue}\\________/ ${normal} ${blue}##########################################" >> $MOTDFILE
echo -e "${bg_white}${blue} _____________________   ${red} ___   ___  ${normal} ${green}  ___  ____  ____   ____ ___  ____  _____ " >> $MOTDFILE
echo -e "${bg_white}${blue}/                     \\  ${red}/   \\ /   \\ ${normal} ${green} / _ \\|  _ \\/ ___| / ___/ _ \\|  _ \\| ____|" >> $MOTDFILE
echo -e "${bg_white}${blue}\\_____________________/  ${red}\\___/ \\___/ ${normal} ${green}| | | | |_) \\___ \\| |  | | | | | | |  _|  " >> $MOTDFILE
echo -e "${bg_white}${red} ___   ${blue} ___  ${red}  ____________________  ${normal} ${green}| |_| |  __/ ___) | |__| |_| | |_| | |___ " >> $MOTDFILE
echo -e "${bg_white}${red}/   \\  ${blue}/   \\ ${red} /                    \\ ${normal} ${green} \\___/|_|   |____/ \\____\\___/|____/|_____|" >> $MOTDFILE
echo -e "${bg_white}${red}\\___/  ${blue}\\___/ ${red} \\____________________/ ${normal} ${red}    ___ ___  ___  ___    ___   _   _  _   " >> $MOTDFILE
echo -e "${bg_white}${red} ___    ____________________  ${blue}  ___  ${normal}   ${red} / __/ _ \\|   \\| __|  / __| /_\\ | \\| |  " >> $MOTDFILE
echo -e "${bg_white}${red}/   \\  /                    \\ ${blue} /   \\ ${normal}   ${red}| (_| (_) | |) | _|  | (__ / _ \\|  ' |  " >> $MOTDFILE
echo -e "${bg_white}${red}\\___/  \\____________________/ ${blue} \\___/ ${normal}   ${red} \\___\\___/|___/|___|  \\___/_/ \\_\\_|\\_|  " >> $MOTDFILE
echo -e "${bg_white}${blue} _______  ${red}  _______________________  ${normal}                                        " >> $MOTDFILE
echo -e "${bg_white}${blue}/       \\ ${red} /                       \\ ${normal} ${blue}##########################################" >> $MOTDFILE
echo -e "${bg_white}${blue}\\_______/ ${red} \\_______________________/ ${normal} ${blue}##########################################" >> $MOTDFILE
echo -e "${bg_white}                                     ${normal} " >> $MOTDFILE
echo -e "" >> $MOTDFILE
echo -e "   ${green}$(hostname) - $DISTRIB_DESCRIPTION" >> $MOTDFILE
echo -e "   ${blue}IP: ${green}${IPADDR##addr:}  ${blue}CPU Cores: ${green}$PROCS  ${blue}Memory: ${green}${MEMSIZE}MB ${blue}  Kernel: ${green}$(uname -r)${normal}" >> $MOTDFILE
echo -e "" >> $MOTDFILE
