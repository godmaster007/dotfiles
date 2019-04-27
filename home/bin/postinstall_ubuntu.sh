#!/bin/bash


################################################################################
# Run in Debug mode
################################################################################
set -x
#set -e
set -v


################################################################################
# Set Github custom variables
################################################################################
# Github and SSH config
echo "Hello, "$USER".  This script will configure your Github and SSH config."

# Username
echo -n "Enter your Github Username (ex: gituser1234) and press [ENTER]: "
read git_user

# Email
echo -n "Enter your Github Email (ex: default@gmail.com) and press [ENTER]: "
read git_email

# Repo
echo -n "Enter your Github Repo (dotfiles.git) and press [ENTER]: "
read git_repo

# These if's test if the variable is is null (has length 0)
# This way if no input is entered it will auto setup my default config
if [ -z $git_user ]; then
  git_user='godmaster007'
fi

if [ -z $git_email ]; then
  git_email='default+default@gmail.com'
fi

if [ -z $git_repo ]; then
  git_repo='dotfiles'
fi

echo Your github username is: $git_user
echo Your github email is: $git_email
echo Your github reponame is: $git_repo
echo Will set the remote url origin of your repo to: git@github.com:$git_user/$(git_repo).git


################################################################################
# Define Variables
################################################################################
# Shows which flavor of ubuntu is installed
FLAVOR=`echo $XDG_SESSION_DESKTOP`
# Shortcut for system maintence comands, change "apt" to "apt-get" if needed
INSTALL="sudo apt -y install"
# Symbolic link directory for manual git clone files
# SLINK="ln -s $HOME/dotfiles/home"
# Change this email to your default email to be used as a variable "$EMAIL"
EMAIL='default+default@gmail.com'
#Change this to git repo
GITUSER="godmaster007"


################################################################################
# Define Paths
################################################################################


################################################################################
# Configure GUI Install Options
################################################################################
# Install Dialog
$INSTALL dialog
# Not sure what this command is doing besides defining the heading
cmd=(dialog --separate-output --checklist "Select Software to Install:" 22 76 16)
# Option can be set as default with "on"
options=(1.0 "Update & Clean" off
1.1 "SSH-KEY (Generate)" off
1.2 "SSH-KEY (Paste pub key into Github)" off
1.3 "Homeshick - Initial install" off
1.4 "Homeshick - Install additional machines" off
1.5 "Homeshick - Clone dotfiles to new machine" off
1.6 "Homeshick - Github Config" off
1.7 "Repositories" off
1.8 "Disable Error Reporting (Remove Apport)" off
1.9 "NA" off
2.0 "NA" off
3.0 "Essential Apps" off
4 "Media" off
5 "Restricted Extras" off
6 "Teamviewer" off
7 "Skype" off
8 "Docky (Desktop app launcher)" off
9 "Chrome" off
10 "Thunderbird" off
11 "NA" off
12 "NA" off
13 "NA" off
14 "Wallpapers" off
15 "Themes (GTK)" off
16 "Virtualbox (Guest) - Insert ISO, restart after install" off
17 "Virtualbox (Host)" off
18 "Touchpad Indicator (Touch bad functionality)" off
19 "Unetbootin (Startup disk creator)" off
20 "Typora (Markdown Editor)" off
20.1 "Boostnote (Markdown Editor for Programers)" off
21 "Dropbox" off
22 "Dropbox-Uploader (Commandline Functionality)" off
23 "Dropbox (Symlinks)" off
24 "LAMP Stack" off
25 "Sublime 3 (Text Editor)" off
26 "Atom (Text Editor)" off
27 "Wireshark (Network Monitor)" off
28 "ClamAV (Virus Protection)" off
28.1 "ClamAV (Uninstall)" off
29 "Youtube-dl (Web downloader)" off
30 "Most (Manpage Highlighting)" off
31 "Ubuntu 18.04 (Custom Tweaks)" off
32 "Geany (IDE)" off
33 "Brackets (IDE)" off
34 "Bluefish (IDE)" off
35 "Kali 2018 (Custom Tweaks)" off
36 "Xfce4 (Dropdown Terminal)" off
37 "Slack (Team Collaboration)" off
38 "na" off
39 "Vtop (System Monitor)" off
40 "Libreoffice" off)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

clear
for choice in $choices
do
  case $choice in
    
    1.0)
    # Update & Clean
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt -y dist-upgrade
    sudo apt -y autoclean
    sudo apt -y autoremove
    sudo apt -y clean
    sudo updatedb
    ;;
    
    1.1)
    # SSH-KEYS (Generate)
    # Generates new ssh-keys with default settings then adds to ssh-agent
    # Passphrase is optional, the (yes "" |) bypasses it
    yes "" | ssh-keygen -t rsa -b 4096
    # Start ssh-agent, add private key, (-k) flag stores passphrase in keychain
    eval $(ssh-agent -s)
    # Add private key to ssh-agent (-k) flag stores passphrase in keychain
    # Example (ssh-add -k ~/.ssh/id_rsa)
    ssh-add ~/.ssh/id_rsa
    ;;
    
    
    1.2)
    # SSH-KEYS (Paste to Github)
    # Uses xclip to copy public key to clipboard then opens link to github
    $INSTALL xclip
    xclip -sel clip < ~/.ssh/id_rsa.pub
    xdg-open https://github.com/settings/ssh/new
    ;;
    
    
    1.3)
    # Homeshick - Initial Install
    # Clone homeshick
    git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
    
    # Add homeshick to .bashrc, enable auto completion and auto refresh
    printf '\n# Source
    if [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then
      source "$HOME/.homesick/repos/homeshick/homeshick.sh"
      source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
    fi' >> $HOME/.bashrc
    
    # Enable Auto Refresh
    printf '\n# Auto Refresh
    homeshick refresh -q
    \n' >> $HOME/.bashrc
    
    # Quick homeshick install
    if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
      git clone https://www.github.com/godmaster007/dotfiles $HOME/.homesick/repos/homeshick godmaster007/dotfiles
      source $HOME/.homesick/repos/homeshick/homeshick.sh
    fi
    
    # Quick homeshick install
    if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
      git clone https://www.github.com/git_user/dotfiles $HOME/.homesick/repos/homeshick godmaster007/dotfiles
      source $HOME/.homesick/repos/homeshick/homeshick.sh
    fi
    
    
    
    
    # Source .bashrc
    source $HOME/.bashrc
    ;;
    
    
    1.4)
    # Homeshick - Install additional machines
    # Quick homeshick install
    if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
      git clone https://www.github.com/godmaster007/dotfiles $HOME/.homesick/repos/homeshick godmaster007/dotfiles
      source $HOME/.homesick/repos/homeshick/homeshick.sh
    fi
    ;;
    
    
    1.5)
    # Homeshick - Clone dotfiles to new machine
    # "--batch" bypasses user input questions like yes/no
    # $HOME/.homesick/repos/homeshick/bin/homeshick --batch clone
    # Cloning from the HTTPS link doesn't require SSH keys to be configured
    homeshick --batch clone https://github.com/godmaster007/dotfiles.git
    # May need to switch back to SSH git@github.com:godmaster007/dotfiles.git
    source $HOME/.bashrc
    source $HOME/.homesick/repos/homeshick/homeshick.sh
    ;;
    
    
    1.6)
    # Homeshick - Github Config
    # homeshick cd dotfiles
    cd $HOME/.homesick/repos/dotfiles
    git config --global user.email "$EMAIL"
    git config --global user.name "$GITUSER"
    git remote set-url origin git@github.com:godmaster007/dotfiles.git
    cd ~
    # Link all files to $HOME
    #$HOME/.homesick/repos/homeshick/bin/homeshick link --force
    ;;
    
    1.7)
    # Repositories
    # Add Canonical_Partners
    sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
    ;;
    
    1.8)
    # Disable Error Reporting (Remove Apport)
    if grep "enabled=0" /etc/default/apport
    then
      echo "Apport Error reporting already disabled"
    else
      sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
      echo "Apport error reporting DISABLED!"
    fi
    sudo apt -y remove --purge apport
    ;;
    
    
    1.9)
    # Uses mlocate to find files
    # Example "locate thunderbird"
    ;;
    
    
    2.0)
    # NA
    ;;
    
    
    3.0)
    # Essential Apps
    # Installs a list of essential linux apps
    for line in $(cat $HOME/bin/essential_apps.txt); do
      sudo apt -y install $line
      if [[ ! $? -eq 0 ]]; then
        echo "Problem in apt install $line" >> output.log
      fi
    done
    ;;
    
    
    4)
    # Media
    sudo DEBIAN_FRONTEND=noninteractive apt -y install libdvd-pkg
    sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure libdvd-pkg
    $INSTALL \
    ffmpeg \
    libavcodec-extra \
    vlc \
    gimp gimp-data gimp-plugin-registry gimp-data-extras \
    shutter
    ;;
    
    
    5)
    # Restricted Extras
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
    $INSTALL ttf-mscorefonts-installer
    echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections
    $INSTALL $FLAVOR-restricted-extras
    ;;
    
    
    6)
    # Teamviewer
    # Screen Sharing & Remote Login
    wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" >> /etc/apt/sources.list.d/teamviewer.list'
    sudo sh -c 'echo "deb http://linux.teamviewer.com/deb preview main" >> /etc/apt/sources.list.d/teamviewer.list'
    sudo apt update
    yes "" | $INSTALL teamviewer
    ;;
    
    
    7)
    # Skype
    # Download then install skype for linux directly from microsoft
    #sudo snap install skype --classic
    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    sudo dpkg -i skypeforlinux-64.deb
    sudo apt install -f -y
    rm -rf skypeforlinux-64.deb
    ;;
    
    
    8)
    # Docky
    # Desktop app launcher
    sudo apt -y install docky
    ;;
    
    
    9)
    # Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    #echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    $INSTALL google-chrome-stable
    ;;
    
    
    10)
    # Thunderbird
    $INSTALL thunderbird
    ;;
    
    
    11)
    # NA
    ;;
    
    
    12)
    # NA
    ;;
    
    
    13)
    # NA
    ;;
    
    
    14)
    # Wallpapers
    # Ubuntu Collection
    $INSTALL \
    ubuntu-wallpapers-* \
    edgy-wallpapers \
    feisty-wallpapers \
    gutsy-wallpapers
    #
    # Dropbox Collection need to fix i think
    #curl "https://www.dropbox.com/sh/yqoksuzhflnyems/AACgHGrBzgATmExaJsB8zR5ma?dl=1" -O -J -L && \
    #sudo unzip Backgrounds_Dropbox.zip -d /usr/share/xfce4/backdrops/
    #rm -rf Backgrounds_Dropbox.zip
    #sudo mv /usr/share/backgrounds/*.jpg /usr/share/xfce4/backdrops/
    #sudo mv /usr/share/backgrounds/*.png /usr/share/xfce4/backdrops/
    ;;
    
    
    15)
    # Themes
    #GTK themes and fonts for XFCE aka xubuntu distro
    #Needs work
    # $INSTALL \
    # arc-theme \
    # numix-* \
    # materia-gtk-theme \
    # gtk-clearlooks-gperfection2-theme \
    # gtk-redshift \
    # gtk-sharp3-gapi
    ;;
    
    
    16)
    # Virtualbox (Guest)
    # Insert guest additions before installing
    #sudo apt update
    #sudo apt -y upgrade
    #sudo apt -y dist-upgrade
    $INSTALL dkms build-essential
    sudo mount -r /dev/sr0 /media
    sudo sh /media/VBoxLinuxAdditions.run
    sudo adduser $USER vboxsf
    sudo reboot now
    ;;
    
    
    17)
    # Virtualbox (Host)
    #Add repo key
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    #Add virtualbox repo
    sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    #sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
    sudo apt update
    $INSTALL dkms gcc make linux-headers-$(uname -r)
    #sudo apt update
    $INSTALL virtualbox-6.*
    sudo usermod -a -G vboxusers $USER
    ;;
    
    
    18)
    # Touchpad Indicator
    # If no app to manage touch pad, use this to "disable touchpad" if needed.
    sudo add-apt-repository ppa:atareao/atareao -y
    sudo apt update
    $INSTALL touchpad-indicator
    ;;
    
    
    19)
    # Unetbootin
    # Boot Disk Creator
    sudo add-apt-repository ppa:gezakovacs/ppa -y
    sudo apt update
    $INSTALL unetbootin
    ;;
    
    
    20)
    # Typora
    # Text to markdown features.
    # Import Public Key
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
    wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
    # Add Typora's repository
    # Below command worked on xubuntu but not elementary vm
    #   sudo add-apt-repository 'deb https://typora.io/linux ./'
    #   sudo apt-get update
    # Adding manually before installing
    echo -e "\ndeb https://typora.io/linux ./" | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get -y install typora
    ;;
    
    
    20.1)
    # Boostnote
    wget https://github.com/BoostIO/boost-releases/releases/download/v0.11.15/boostnote_0.11.15_amd64.deb
    sudo dpkg -i boostnote_0.11.15_amd64.deb
    rm boostnote_0.11.15_amd64.deb
    ;;
    
    
    21)
    # Dropbox
    $INSTALL nautilus-dropbox
    ;;
    
    
    22)
    # Dropbox-Uploader
    # Enables commandline functionality
    # After install, must add developers token. Paste token into app from dropbox site.
    # https://www.dropbox.com/developers/apps/
    # https://www.dropbox.com/developers/apps/info/mmhp9y0bi8yadh8
    git clone https://github.com/andreafabrizi/Dropbox-Uploader.git
    chmod +x /Dropbox-Uploader/dropbox_uploader.sh
    ./Dropbox-Uploader/dropbox_uploader.sh
    ;;
    
    
    23)
    # Dropbox (Symlinks)
    # Symlink essential files from dropbox to avirtual machine.
    # Alternative option to git, dropbox must be installed on host, enable shared folder.
    # ln -s media/sf_Dropbox/Scripts/aliases/.bash_aliases $HOME/
    # ln -s media/sf_Dropbox/Scripts/aliases/postinstall_ubuntu.sh $HOME/
    ;;
    
    
    24)
    # LAMP Stack
    # Webserver Config
    # echo "Installing Apache"
    # apt install apache2 -y
    # echo "Installing Mysql Server"
    # apt install mysql-server -y
    # echo "Installing PHP"
    # apt install php libapache2-mod-php php-mcrypt php-mysql -y
    # echo "Installing Phpmyadmin"
    # apt install phpmyadmin -y
    # echo "Cofiguring apache to run Phpmyadmin"
    # echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
    # echo "Enabling module rewrite"
    # a2enmod rewrite
    # echo "Restarting Apache Server"
    # service apache2 restart
    ;;
    
    25)
    # Sublime 3
    # Text Editor
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt update
    $INSTALL sublime-text
    ;;
    
    26)
    # Atom
    # Text Editor
    curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt update
    $INSTALL atom
    ;;
    
    27)
    # Wireshark
    # Network Monitor
    echo wireshark-common wireshark-common/install-setuid boolean true | sudo debconf-set-selections
    sudo DEBIAN_FRONTEND=noninteractive apt -y install wireshark
    sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common
    sudo adduser $USER wireshark
    ;;
    
    28)
    # ClamAV (Install)
    # Virus Protection
    # Troubleshooting, first stop deamon then rerun update
    # sudo systemctl stop clamav-freshclam.service
    # sudo freshclam
    # OR
    # sudo pkill -15 -x freshclam
    # sudo freshclam
    # OR
    # sudo /etc/init.d/clamav-freshclam stop
    # sudo freshclam
    # sudo /etc/init.d/clamav-freshclam start
    $INSTALL clamav clamav-daemon clamtk
    sudo freshclam
    sudo /etc/init.d/clamav-daemon start
    ;;
    
    
    28.1)
    # ClamAV (Uninstall)
    sudo apt-get -y remove --purge clamav*
    ;;
    
    
    29)
    # Youtube-dl
    # Web downloader
    # Initially, used the alternative install
    # Now changed to pip install method so it's easier to update
    # Alternative Install
    # sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
    # sudo chmod a+rx /usr/local/bin/youtube-dl
    # Pip Install
    $INSTALL curl
    $INSTALL ffmpeg
    $INSTALL python-pip
    # sudo pip install youtube-dl
    sudo -H pip install --upgrade youtube-dl
    ;;
    
    30)
    # Most
    # Manpage Highlighting
    $INSTALL most
    if grep "export PAGER='most'" ~/.bashrc
    then
      echo "Most already added to ~/.bashrc"
    else
      echo -e "#Color man-pages persistently\nexport PAGER='most'" >> ~/.bashrc
      source ~/.bashrc
      echo "Most Added to ~/.bashrc"
    fi
    ;;
    
    31)
    # Ubuntu 18.04 (Custom Tweaks)
    $INSTALL \
    gnome-tweak-tool \
    gnome-shell-extensions \
    dconf-editor;
    sudo apt -y purge ubuntu-web-launchers
    ;;
    
    32)
    # Geany
    # IDE
    $INSTALL geany geany-plugin-addons geany-plugin-treebrowser
    ;;
    
    33)
    # Brackets
    # IDE
    sudo add-apt-repository ppa:webupd8team/brackets -y
    sudo apt update
    $INSTALL brackets
    ;;
    
    34)
    # Bluefish
    # IDE
    $INSTALL bluefish bluefish-plugins
    ;;
    
    35)
    # Kali 2018 (Custom Tweaks)
    # Auto Login GNOME Desktop
    sed -i 's/#AutomaticLoginEnable = true/AutomaticLoginEnable = true/g' /etc/gdm3/daemon.conf
    sed -i 's/#AutomaticLogin = root/AutomaticLogin = root/g' /etc/gdm3/daemon.conf
    ;;
    
    36)
    # XFCE4
    # xfce terminal, has more functionality than basic lubuntu
    # Enable "Dropdown Terminal" or make a shortcut for it
    $INSTALL xfce4-terminal
    ;;
    
    37)
    # Slack (Team Collaboration)
    sudo snap install slack --classic
    ;;
    
    38)
    # Rootcheck
    # Add to main script
    aptget='sudo apt-get'
    if [ `whoami` = 'root' ]; then
      aptget='apt-get'
    fi
    ;;
    
    39)
    # Vtop
    # System Monitor
    # Bit heavy for a VM depending which base distro and dependencies
    sudo npm -y install -g vtop
    ;;
    
    40)
    # Libre Office 6.0
    # Office Suite
    sudo add-apt-repository ppa:libreoffice/ppa -y
    sudo apt update
    $INSTALL libreoffice
    ;;
    
  esac
done
