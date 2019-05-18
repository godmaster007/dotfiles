# .bash_aliases
# lets see if vscode can update github
# now its time for some changes with atom!

################################################################################
# TESTING
################################################################################
# Testing git-plus for atom, making sure it's working!
# test thsi fuckiang push


# ################################################################################
# # Homeshick - Basic Git Functionality
# ################################################################################

# # Edit Bash Aliases
# # Automatically sources .bashrc, commits and pushs to github
# # Argument 1 = nano, vim (shell editors) need to add non shell app functionality
# # Example = EA! vim
# EA! () {
#   "$1" ~/.bash_aliases
#   source ~/.bashrc
#   echo ".bash_aliases - Saved & Sourced!!"
#   homeshick cd dotfiles
#   git add .
#   git commit -am ".bash_aliases updated"
#   git push
#   cd ~
#   echo "Dotfiles PUSHED!!!!"
#   homeshick check
# }

# # Edit postinstall script
# # Automatically pushes changes to github on exit
# # Argument 1 = nano, vim, vi, etc (shell editors)
# # Example = EP! nano
# EP! () {
#   "$1" ~/bin/postinstall_ubuntu.sh
#   echo "postinstall_ubuntu.sh - Saved!!"
#   homeshick cd dotfiles
#   git add .
#   git commit -am "postinstall_ubuntu.sh UPDATED"
#   git push
#   cd ~
#   echo "### Postinstall_ubuntu.sh UPDATED AND PUSHED! ###"
#   homeshick check
# }

# Push local changes
# Updates dotfiles repo with local changes
# Argument 1 = "description of changes" in quotes
# Example = PUSH! "New changes to the file"
PUSH! () {
  homeshick cd dotfiles
  git add .
  git commit -am "$1"
  git push
  cd ~
}

# Check repo status
alias CHECK!='homeshick check'
# Download current repo version
alias PULL!='homeshick pull'
# Check repo status
alias STATUS!='homeshick cd dotfiles && git status && cd ~'
# Add more files to the dotfiles repo
TRACK! () {
  homeshick track dotfiles "$1"
}

################################################################################
# Git - Basic Functionality
################################################################################

# Status
GS! () {
  cd dotfiles/
  git status
  cd ~
}

# Push
# Sync local changes to git repo
# Argument 1 = Define changes with quotes
# Example = GPUSH! "These are the new changes to the file"
GPUSH! () {
  cd dotfiles/
  git add .
  git commit -am "$1"
  git push
  cd ~
}

# Pull
# Download changes in repo to local files
GPULL! () {
  cd dotfiles/
  git pull
  cd ~
}

################################################################################
# .bash_aliases
################################################################################

# Shorten
alias BA='echo '$HOME/.bash_aliases''
# View
alias VBA!='clear; clear; c $(BA)'
# Source
alias SA!='source ~/.bashrc'
# Edit & Source - Sublime 3
alias EAS!='subl ~/.bash_aliases && SA! && echo "Saved & Sourced"'
# Edit & Source - Gedit
alias EAG='gedit $(BA); SA!; echo "Saved & Sourced"'
# Edit & Source - Vim
alias EAV='vim $(BA); SA!; echo "Saved & Sourced"'
#
#Download - need to update links, it's probably better to just use the clone functionality
#alias DBA='mv $(BA) $(BA).BAK; wget -O $(BA) https://github.com/godmaster007/bash_aliases/master/.bash_aliases; source ~/.bashrc'
#alias DBA='mv $(BA) $(BA).BAK; wget -O $(BA) https://goo.gl/zR5TDS; source ~/.bashrc'
# Upload
#alias UBA!='DBU upload $(BA) /DB_Uploads/'
# Download Bash Aliases & Postinstall Script
#alias DALL='DBA && DPI!'
# Upload .bash_aliases, postinstall_ubuntu.sh, .bashrc
#alias UALL!='UBA! && UPI! && DBU upload ~/.bashrc /DB_Uploads/'


################################################################################
# postinstall_ubuntu.sh
################################################################################
# Shorten
alias PI='echo "$HOME/bin/postinstall_ubuntu.sh"'
# View
alias VPI!='c $(PI)'
#Download
#alias DPI!='mv $(PI) $(PI).BAK; wget -O $(PI) https://goo.gl/TLKUtD; chmod +x $(PI)'
#Upload
#alias UPI!='DBU upload $(PI) /DB_Uploads/'


################################################################################
# Package Managers
################################################################################
# Update Debian
alias UPDATE='sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y'
alias CLEAN='sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y'
alias UC!='UPDATE && CLEAN'
alias UCR!='UPDATE && CLEAN && reboot'
alias UCS!='UPDATE && CLEAN && shutdown'
# View Installed Packages
showpkg () {
  apt-cache pkgnames | grep -i "$1" | sort
  return;
}
# Install Variable
alias INSTALL='sudo apt -y install'


################################################################################
# YouTube-DL
################################################################################
# Use inside destination directorly
# Troubleshoot: "youtube-dl -F --verbose https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-cSmEL0MmKfx02_Y7lKxDyH"

# Download playlist as MP3 files
YDL_M () {
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

# Download playlist as MP3 files into shared directory
YDL_MS () {
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

# Download playlist as WAV files
YDL_W () {
  youtube-dl \
  --download-archive downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format wav -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  "$1"
}

# Download playlist as WAV files into shared directory
YDL_WS () {
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


# # Download playlist as MP3 files
# YDM () {
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format mp3 -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   --embed-thumbnail \
#   "$1"
# }

# # Download playlist as MP3 files into shared directory
# YDM! () {
#   cd /media/sf_Downloads/Youtube_DL/mp3
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format mp3 -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   --embed-thumbnail \
#   "$1"
#   cd ~
# }

# # Download playlist as WAV files
# YDW () {
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format wav -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   "$1"
# }

# # Download playlist as WAV files into shared directory
# YDW! () {
#   cd /media/sf_Downloads/Youtube_DL/wav
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format wav -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   "$1"
#   cd ~
# }


################################################################################
# Dropbox-Uploader
################################################################################
# This app enables commandline functionality for dropbox
# Details - https://github.com/andreafabrizi/Dropbox-Uploader
alias DBU='./Dropbox-Uploader/dropbox_uploader.sh'
# Example - Upload aliases to dropbox root dir
#   DBU upload ~/.bash_aliases /


################################################################################
# Network Admin
################################################################################
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


################################################################################
# Networking
################################################################################
# Generate
alias SSHKEY='yes "" | ssh-keygen -t rsa -b 4096'
# Copy - Usage Example: ssh-copy-id -p 2022 root@76.14.134.182
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


################################################################################
# Password Generator
################################################################################
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


################################################################################
# File Management
################################################################################
# Drive Details
# View size, mountpoint, etc...
alias DISK!="sudo lshw -C disk;uname -a"

# Formating
# Shred & zero fill
# Example (zero fill only) - "sudo shred -vzn 0 /dev/sda"
# Example (shred twice then zero fill) - "sudo shred -vzn 2 /dev/sda"

# View Directory
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

#View Hidden Files
alias l.='ls -d .* --color=auto'
alias lsh="ls -ld .??*"

#Disk Usage
alias df="df -H"
alias du="du -ch"
alias du1='du -d 1'

#RSYNC - Copy with Progress & Resume
alias rsyncp="rsync --progress -ravz"

#Move files and folders recursive, preserve perm and owner
alias moveff="cd /source/directory; tar cf - . | tar xf - -C /destination/directory"

#WGET - Continous Web Downloader
alias wget="wget -c"




#####################
## Custom Settings ##
#####################

#Short Cuts
alias h="clear; c ~/.bash_history"
alias j="jobs -l"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

#Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

#Confirmations
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -i'

#Python Pigments - Syntax Highlighting
alias c='pygmentize -g'

#Highlighting with Rows
alias cc='pygmentize -g -O style=colorful,linenos=1'

#Powerswitches
alias reboot='sudo reboot -h now'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown -P now'

#Plex Server - Manually turn screen off and on
alias TF="sudo vbetool dpms off && read -s -n 1 && sudo vbetool dpms on"




##################
## CentOS 6.10  ##
##################

#Add PATH - CentOS
#alias AAPC='echo -e '#Source Aliases\nif [ -f ~/.bash_aliases ]; then\n. ~/.bash_aliases\nfi\n' >> ~/.bashrc;source ~/.bashrc'

#TEMP Static IP - Adapter 2 (eth1)
alias TEMPIP="ifconfig eth1 192.168.56.101 netmask 255.255.255.0 up"

#Static IP - Adapter 2 (eth1)
alias STATICIP="echo -e 'DEVICE=eth1\nTYPE=Ethernet\nONBOOT=yes\nNM_CONTROLLED=no\nBOOTPROTO=static\nIPADDR=192.168.56.99\nNETMASK=255.255.255.0' > /etc/sysconfig/network-scripts/ifcfg-eth1"

#Update EPEL
alias yumUP='yum -y update && yum -y upgrade'
alias yumCL='yum clean all'
alias yumUC='yumUP && yumCL'

#View Installed Packages
alias yumIN='yum list installed'




##############
## Archived ##
##############
