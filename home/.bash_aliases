###############################################################################
# .bash_aliases
###############################################################################

# Display alias syntax
alias VB='clear; clear; c ~/.bash_aliases'

# Reload shell settings
alias SOURCE='. ~/.bashrc'

# Download bootstrap.sh
alias BOOT='sudo apt -y install curl; curl -sLo bootstrap.sh git.io/fhdhf && chmod +x bootstrap.sh'

# Show most used commands
#history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10

###############################################################################
# Git - Homeshick
###############################################################################

# Check status
alias CHECK='homeshick check ; homeshick cd dotfiles && git status && cd ~'

# Download current version
alias PULL='homeshick pull'

# Add more files to dotfiles tracking castle
TRACK! () {
  homeshick track dotfiles "$1"
}

# Update master with local changes - IE (PUSH "Changed some stuff")
PUSH () {
  homeshick cd dotfiles
  git add .
  git commit -am "$1"
  git push
  cd ~
}

###############################################################################
# Processes
###############################################################################

# Tload - System Load Graphic
alias sysload="tload -s 10"

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

###############################################################################
# Config
###############################################################################

# Update & Clean plus reboot or shutdown
alias UC='sudo apt update ; sudo apt upgrade -y ; \
sudo apt dist-upgrade -y ; sudo apt autoremove -y ; \
sudo apt autoclean -y ; sudo apt clean -y'
alias UCR='UC ; reboot'
alias UCS='UC ; shutdown'

# View Installed Packages
showpkg () {
  apt-cache pkgnames | grep -i "$1" | sort | less
  return;
}

# Install
alias INSTALL='sudo apt -y install'

###############################################################################
# Security
###############################################################################

# SSH Keys (Generate) - EI(SSHKEY)
alias SSHKEY='yes "" | ssh-keygen -t rsa -b 4096'
# SSH Keys (Copy) - IE (ssh-copy-id -p 2022 root@76.14.134.182)

###############################################################################
# Networking
###############################################################################

# Nmap - Network Mapper & Port Scanner
alias NMAP='nmap --iflist'

# IP Tools - (https://www.poftut.com/linux-ss-command-tutorial-with-examples)
alias iproute="ip route; ip -s link; ip maddr; ss -l; ss -t -a"

# Ping - Echo Requets to Network Hosts
alias ping='ping -c 5'

# IPs - Private & Public
alias IP='echo "Private IP" && ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p" && echo "Public IP" && dig +short myip.opendns.com @resolver1.opendns.com'

# Appache - View http server log
alias phplog="tail -f /var/log/apache2/error_log"

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


###############################################################################
#Youtube-dl
###############################################################################

# NEW DYNAMIC CONFIG TESTING

PL1='https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fdN6fcVne88peQ97qjGW-4'
PL2='https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-co5UkkjbMf8R_KWnM_KFBz'
PL1D="cd $HOME/Music/Youtube/TEST1"
PL2D="cd $HOME/Music/Youtube/TEST2"

YD1 () {
  $PL1D
  youtube-dl \
  --download-archive PL1D_downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format "mp3" -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  --embed-thumbnail \
  $PL1;
  cd ~
}



# $1 = LINK (Either song or playlist link from youtube)
# TEST1 = https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fdN6fcVne88peQ97qjGW-4
# TEST2 = https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-co5UkkjbMf8R_KWnM_KFBz
# $2 = DESTINATION (Full path, if VM create dir with host first)
# TEST1 DIR = cd /mnt/c/Users/nicho/Youtube/TEST1
# TEST2 DIR = cd /mnt/c/Users/nicho/Youtube/TEST2
# $3 = FORMAT (Either mp3 OR wav *if unspecified default is mp3*)
#
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

# OLD CONFIGURATIONS
# Troubleshoot: "youtube-dl -F --verbose https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-cSmEL0MmKfx02_Y7lKxDyH"
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

###############################################################################
# Dropbox-Uploader
###############################################################################

# Commandline functionality
# Source (https://github.com/andreafabrizi/Dropbox-Uploader)
# IE - Upload aliases to dropbox root (DBU upload ~/.bash_aliases /)
alias DBU='./Dropbox-Uploader/dropbox_uploader.sh'

###############################################################################
# Password Generator
###############################################################################

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

###############################################################################
# File Management
###############################################################################

# Drive Details
alias DISK!="sudo lshw -C disk;uname -a"

# Format with zeros - IE (shred -vzn 0 /dev/sda)

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

###############################################################################
# Settings
###############################################################################

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

###############################################################################
# Extractor
###############################################################################

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}
