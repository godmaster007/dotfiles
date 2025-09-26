
### Bootstrap - Download script ###
alias DLBOOT='sudo apt -y install curl && curl -sLo bootstrap.sh git.io/fhdhf && chmod +x bootstrap.sh'


### Bash Aliases ###
# View alias syntax
alias VB='clear; clear; c ~/.bash_aliases'
# Reload shell settings
alias SOURCE='. ~/.bashrc'



### Git Commands with Homeshick ###
# Check status
alias CHECK='homeshick check ; homeshick cd dotfiles && git status && cd ~'
# Download current version
alias PULL='homeshick pull'
# Add more files to dotfiles tracking castle
TRACK! () {
  homeshick track dotfiles "$1"
}
# Update master with local changes
# example: (PUSH "Updated Stuff")
PUSH () {
  homeshick cd dotfiles
  git add .
  git commit -am "$1"
  git push
  cd ~
}



### Plex Media Server ###
#Fix media access
alias fmedia='sudo chown -R dopeman:deluge ~/Media/wd12/ && sudo chmod -R 775 ~/Media/wd12/'
#Manually turn screen off and on - Headless Ubuntu Server
alias TF="sudo vbetool dpms off && read -s -n 1 && sudo vbetool dpms on"
#Display Core Temp
alias TEMP='sensors -f'
#Server Firewall - check status of sshd
alias f2b='sudo fail2ban-client status sshd | less'



### Clipboard Managment###
#Copy file contents to clipboard
CLIP () {
  xclip -sel clip < "$1"
}



### System Management ###
# System Load Graphic
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



### System Commands ###
#Update & Clean
alias UC='\
sudo apt update ; \
sudo apt upgrade -y ; \
sudo apt dist-upgrade -y ; \
sudo apt autoremove -y ; \
sudo apt autoclean -y ; \
sudo apt clean -y'
#Reboot & Shutdown
alias UCR='UC ; reboot'
alias UCS='UC ; shutdown'
# Powerswitches
alias reboot='sudo shutdown -r now'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown -h now'
# View Installed Packages
showpkg () {
  apt-cache pkgnames | grep -i "$1" | sort | less
  return;
}
# Install
alias INSTALL='sudo apt -y install'


## SSH Config ##
# SSH Keys (Generate) - EI(SSHKEY)
alias SSHKEY='yes "" | ssh-keygen -t rsa -b 4096'
# SSH Keys (Copy) - IE (ssh-copy-id -p 2022 root@76.14.134.182)



### Networking ###
# Nmap - Network Mapper & Port Scanner
alias NMAP='nmap --iflist'
# IP Tools (https://www.poftut.com/linux-ss-command-tutorial-with-examples)
alias iproute="ip route; ip -s link; ip maddr; ss -l; ss -t -a"
# Ping - Echo Request to Network Hosts
alias ping='ping -c 5'
# IP Details: Private & Public
alias IP='echo "Private IP" && ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p" && echo "Public IP" && dig +short myip.opendns.com @resolver1.opendns.com'
# Apache - View http server log
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



### Youtube Downloader ###
#youtube-dl was forked into yt-dlp
#Download as MP3 into the shared folder of the guest vm/host
# YD () {
#   # Define the directory where you want to store your downloads and archive file
#   local download_dir="/media/sf_Downloads/yt_dlp"

#   yt-dlp \
#   --cookies-from-browser firefox \
#   --download-archive "${download_dir}/MP3_downloaded.txt" \
#   --paths "$download_dir" \
#   --no-post-overwrites \
#   -f 'bestaudio' \
#   -x --audio-format mp3 --audio-quality 0 \
#   --add-metadata --embed-thumbnail \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   -o '%(title)s.%(ext)s' \
#   -i \
#   "$1"
# }


YD () {
  local download_dir="/media/sf_Downloads/yt_dlp"

  # Check if yt-dlp is installed
  command -v yt-dlp >/dev/null 2>&1 || {
    echo >&2 "yt-dlp is not installed. Aborting."
    return 1
  }

  # Create download directory if it doesn't exist
  mkdir -p "$download_dir"

  yt-dlp \
    --cookies-from-browser firefox \
    --download-archive "${download_dir}/MP3_downloaded.txt" \
    --paths "$download_dir" \
    --no-post-overwrites \
    -f 'bestaudio' \
    -x --audio-format mp3 --audio-quality 0 \
    --add-metadata --embed-thumbnail \
    --metadata-from-title '%(artist)s - %(title)s' \
    --restrict-filenames \                           # Auto-rename for safe filenames
    --progress \                                      # Force progress bar
    -o '%(title)s.%(ext)s' \
    -i \
    "$@"
}



# #Download playlist as WAV files
# YDW () {
#   cd $HOME/YOUTUBE/WAVE
#   yt-dlp \
#   --download-archive WAVE_downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format wav -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   "$1"
#   cd ~
# }



### Dropbox-Uploader ###
# Command-Line functionality
# Source (https://github.com/andreafabrizi/Dropbox-Uploader)
# EX: Upload aliases to dropbox root (DBU upload ~/.bash_aliases /)
alias DBU='./Dropbox-Uploader/dropbox_uploader.sh'



## Password Generator ##
function randpassw() {
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


### File Management ###
#Drive Details
alias DISK="sudo lshw -C disk;uname -a"
#Format with zeros - example: "shred -vzn 0 /dev/sda"
# Tree view
function tree() {
  pwd
  ls -R | grep ":$" |   \
  sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}
#Directory Contents
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
#Copy files with progress and resume
alias rsyncp="rsync --progress -ravz"
#Move files and folders recursive, preserve perm and owner
alias moveff="cd /source/directory; tar cf - . | tar xf - -C /destination/directory"
#Web downloader with continous flag
alias wget="wget -c"


### Settings ###
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



### Syntax Highlighting ###
#Python Pigments
alias c='pygmentize -g'
#Highlight with Rows
alias cc='pygmentize -g -O style=colorful,linenos=1'



### File Extractor ###
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
