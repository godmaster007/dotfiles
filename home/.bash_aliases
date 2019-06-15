###########################################################
## BASH ALIASES (.bash_aliases)
###########################################################
# View
alias VB='clear; clear; c ~/.bash_aliases'
# Source
alias SOURCE='source ~/.bashrc'

###########################################################
## GIT (HOMESHICK)
###########################################################
# Check repo status
alias CHECK='homeshick check ; homeshick cd dotfiles && git status && cd ~'
# Download current repo version
alias PULL='homeshick pull'
# Add more files to the dotfiles repo
TRACK! () {
  homeshick track dotfiles "$1"
}
# Update master repo with new changes
# $1 (Short description of changes with quotes " ")
# Example (PUSH "Changed some stuff")
PUSH () {
  homeshick cd dotfiles
  git add .
  git commit -am "$1"
  git push
  cd ~
}

###########################################################
## SYS CONFIG (DEBIAN)
###########################################################
# Maintenance
alias UPDATE='sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y'
alias CLEAN='sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y'

alias UC='sudo apt update ; sudo apt upgrade -y ; \
sudo apt dist-upgrade -y ; sudo apt autoremove -y ; \
sudo apt autoclean -y ; sudo apt clean -y'

alias UC!='UPDATE && CLEAN'
alias UCR='UC ; reboot'
alias UCS='UC ; shutdown'

# View Installed Packages
showpkg () {
  apt-cache pkgnames | grep -i "$1" | sort
  return;
}
# Install
alias INSTALL='sudo apt -y install'
# Process Highlighter 1
alias psx='ps -auxw | grep $1'
# Process Highlighter 2
psa () {
  ps aux | grep $1
}
# Kill Process with Full Name
kp () {
  ps aux | grep $1 > /dev/null
  mypid=$(pidof $1)
  if [ "$mypid" != "" ]; then
    kill -9 $(pidof $1)
    if [[ "$?" == "0" ]]; then
      echo "PID $mypid ($1) killed."
    fi
  else
    echo "None killed."
  fi
  return;
}
# Generate SSHKEY
alias SSHKEY='yes "" | ssh-keygen -t rsa -b 4096'
# Copy SSHKEY - Usage Example: ssh-copy-id -p 2022 root@76.14.134.182
sshC () {
  ssh-copy-id "$1";
}
# Tload - System Load Graphic
alias sysload="tload -s 10"
# Nmap - Network Mapper & Port Scanner
alias NMAP='nmap --iflist'
# Netstat - Port Scanner (Obsolete) - Alternatives Below
alias ports='netstat -tulanp'
# IP Tools Stats
# https://www.poftut.com/linux-ss-command-tutorial-with-examples/
alias iproute="ip route; ip -s link; ip maddr; ss -l; ss -t -a"
# Ping - Echo Requets to Network Hosts
alias ping='ping -c 5'
# IPs - Private & Public
alias IP='echo "Private IP" && ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p" && echo "Public IP" && dig +short myip.opendns.com @resolver1.opendns.com'
# echo "Public IP" && dig +short myip.opendns.com @resolver1.opendns.com
# Appache - View http server log
alias phplog="tail -f /var/log/apache2/error_log"
# Memory Stats
alias meminfo='free -m -l -t'
# Show top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# Show top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# GPU & Ram Details
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
# BSD DNS Traffic Monitor
alias dnstop='dnstop -l 5 eth1'
# Network Traffic Monitor
alias vnstat='vnstat -i eth1'
# Displays Bandwidth Usage by Host
alias iftop='iftop -i eth1'
# Dumps Traffic on Networks
alias tcpdump='tcpdump -i eth1'
# Query or control network driver and hardware settings
alias ethtool='ethtool eth1'

###########################################################
## YOUTUBE-DL
#########################################################
# $1 = LINK (Either song or playlist link from youtube)
# TEST1 = https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fdN6fcVne88peQ97qjGW-4
# TEST2 = https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-co5UkkjbMf8R_KWnM_KFBz
# $2 = DESTINATION (Full path, if VM create dir with host first)
# TEST1 DIR = cd /mnt/c/Users/nicho/Youtube/TEST1
# TEST2 DIR = cd /mnt/c/Users/nicho/Youtube/TEST2
# $3 = FORMAT (Either mp3 OR wav *if unspecified default is mp3*)
# 
#
#
# Troubleshoot: "youtube-dl -F --verbose https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-cSmEL0MmKfx02_Y7lKxDyH"
# Download playlist as MP3 files
# WORKING OUT THE BUGGS
# YD () {
#   "$2"
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format "$3" -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   if [ "$3" = 'mp3' ]; then
#     --embed-thumbnail \
#   fi
#   "$1"
#   cd ~
# }



YD_M () {
  youtube-dl \
  --download-archive downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format mp3 -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  --embed-thumbnail \
  "$1"
}
# Download playlist as WAV files
YD_W () {
  youtube-dl \
  --download-archive downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format wav -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  "$1"
}
# Download playlist as MP3 files into shared directory
YD_MS () {
  cd /mnt/c/Users/nicho/Downloads/YoutubeDL/mp3
  youtube-dl \
  --download-archive downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format mp3 -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  --embed-thumbnail \
  "$1"
  cd ~
}
# Download playlist as WAV files into shared directory
YD_WS () {
  cd /mnt/c/Users/nicho/Downloads/YoutubeDL/wav
  youtube-dl \
  --download-archive downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format wav -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  "$1"
  cd ~
}

###########################################################
## DROPBOX-UPLOADER
###########################################################
# This app enables commandline functionality for dropbox
# Details - https://github.com/andreafabrizi/Dropbox-Uploader
alias DBU='./Dropbox-Uploader/dropbox_uploader.sh'
# Example - Upload aliases to dropbox root dir
#   DBU upload ~/.bash_aliases /

###########################################################
## PASS GENERATOR
###########################################################
function randpassw(){
  if [ -z $1 ]; then
    MAXSIZE=10
  else
    MAXSIZE=$1
  fi
  array1=(
  q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D
  F G H J K L Z X C V B N M 1 2 3 4 5 6 7 8 9 0
  \! \@ \$ \% \^ \& \* \! \@ \$ \% \^ \& \* \@ \$ \% \^ \& \*
  )
  MODNUM=${#array1[*]}
  pwd_len=0
  while [ $pwd_len -lt $MAXSIZE ]
  do
    index=$(($RANDOM%$MODNUM))
    echo -n "${array1[$index]}"
    ((pwd_len++))
  done
  echo
}

###########################################################
## FILE MANAGEMENT
###########################################################
# Drive Details - size, mountpoint, etc
alias DISK!="sudo lshw -C disk;uname -a"
# Formating
# Example (zero fill only) - "sudo shred -vzn 0 /dev/sda"
# Example (shred twice then zero fill) - "sudo shred -vzn 2 /dev/sda"
#
# Tree view
function tree(){
  pwd
  ls -R | grep ":$" |   \
  sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}
# Directory Contents
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
# View Hidden Files
alias l.='ls -d .* --color=auto'
alias lsh="ls -ld .??*"
# Disk Usage
alias df="df -H"
alias du="du -ch"
alias du1='du -d 1'
# RSYNC - Copy with Progress & Resume
alias rsyncp="rsync --progress -ravz"
# Move files and folders recursive, preserve perm and owner
alias moveff="cd /source/directory; tar cf - . | tar xf - -C /destination/directory"
# WGET - Continous Web Downloader
alias wget="wget -c"

###########################################################
## SETTINGS
###########################################################
# Short Cuts
alias h="clear; c ~/.bash_history"
alias j="jobs -l"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# Confirmations
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -i'
# Python Pigments - Syntax Highlighting
alias c='pygmentize -g'
# Highlighting with Rows
alias cc='pygmentize -g -O style=colorful,linenos=1'
# Powerswitches
alias reboot='sudo reboot -h now'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown -P now'
# Plex Server - Manually turn screen off and on
alias TF="sudo vbetool dpms off && read -s -n 1 && sudo vbetool dpms on"

###########################################################
## 
###########################################################
