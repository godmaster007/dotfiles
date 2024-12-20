#!/bin/bash


### DEBUG
#set -x
#set -e
set -v

### Define Variables
INSTALL="sudo apt -y install"
FLAVOR=`echo $XDG_SESSION_DESKTOP`

### Configure GUI
$INSTALL dialog
cmd=(dialog --separate-output --checklist "Select Software to Install:" 22 76 16)

### Set options as default with "on"
options=(1.0 "Update & Clean" on
1.1 "SSH-KEY (Generate)" off
1.2 "SSH-KEY (Paste pub key into Github)" off
1.3 "Homeshick (Install)" off
1.4 "Homeshick (HTTPS Clone dotfiles repo)" off
1.7 "Repositories" off
1.8 "Disable Error Reporting (Remove Apport)" off
1.9 "NA" off
2.0 "Windows 10 Ubuntu Apps (non gui)" off
3.0 "Essential Apps" off
4 "Media" off
5 "Restricted Extras" off
6 "Teamviewer" off
7 "Skype" off
8.0 "Docky (Desktop app launcher)" off
8.1 "Plank (Desktop app launcher)" off
9 "Chrome" off
10 "Thunderbird" off
11 "Plank (Dsktop app launcher)" off
12 "lm-sensors (CPU & HD Temp)" off
13 "NA" off
14 "Wallpapers" off
15 "Themes (GTK)" off
16 "Virtualbox (Guest) - Insert ISO, restart after install" off
17 "Virtualbox (Host)" off
18 "Touchpad Indicator (Touch bad functionality)" off
19 "Unetbootin (Startup disk creator)" off
20 "Boostnote (Markdown Editor)" off
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
36 "Xfce4 Terminal - Dropdown" off
37 "Brave - Browser" off
38 "ddgr - DuckDuckGo from terminal" off
39 "Vtop - Sys Monitor" off
40 "Libreoffice" off
41 "Kali Xfce - Enable Autologin" off)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

clear
for choice in $choices
do
  case $choice in
    
    1.0)
    ### Update & Clean
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
    ### Homeshick - Initial Install
    
    ## Github and SSH Config
    
    ## Define Variables
    
    echo "Hello, "$USER".  This script will configure your Github and SSH config."
    # Username
    echo -n "Enter your Github Username (ex: gituser1234) and press [ENTER]: "
    read git_user
    # Email
    echo -n "Enter your Github Email (ex: default@gmail.com) and press [ENTER]: "
    read git_email
    # Repo
    echo -n "Enter your Github Repo (ex: dotfiles) and press [ENTER]: "
    read git_repo
    
    ## Default Variables
    
    # -z (has length 0)
    if [ -z $git_user ]; then
      git_user='godmaster007'
    fi

    if [ -z $git_email ]; then
      git_email='nicholaskoron+github@gmail.com'
    fi
    
    if [ -z $git_repo ]; then
      git_repo='dotfiles'
    fi

    git_URL="https://www.github.com/"$git_user"/"$git_repo".git"
    
    echo "Your Github variables are:
    Username: $git_user
    Email: $git_email
    Reponame: $git_repo
    Remote URL Origin: $git_URL"
    
    
    # Remote URL origin: "https://www.github.com/"$git_user"/"$git_repo".git"
    # Repo remote url origin SSH: git@github.com:$git_user/"$git_repo".git
    # Repo remote url origin HTTPS:  https://www.github.com/"$git_user"/"$git_repo".git


    ### Clone homeshick
    git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick


    ### Add homeshick to .bashrc
    printf '\n# Source
    if [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then
      source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    fi' >> $HOME/.bashrc
    
    
    # ### Add homeshick to .bashrc, enable auto completion and auto refresh
    # printf '\n# Source
    # if [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then
    #   source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    #   source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
    # fi' >> $HOME/.bashrc
    
    
    ### Enable Auto Refresh
    printf '\n# Auto Refresh
    homeshick refresh -q
    \n' >> $HOME/.bashrc
    
    
    # # Clone private dotfiles repo
    # if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
    #   git clone https://www.github.com/"$git_user"/"$git_repo" $HOME/.homesick/repos/homeshick "$git_user"/"$git_repo"
    #   source $HOME/.homesick/repos/homeshick/homeshick.sh
    # fi
    
    # # Clone private dotfiles repo
    # if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
    #   git clone $git_URL $HOME/.homesick/repos/homeshick "$git_user"/"$git_repo"
    #   source $HOME/.homesick/repos/homeshick/homeshick.sh
    # fi


    ### Homeshick (HTTPS batch clone dotfiles to new machine)
    # "--batch" bypasses user input questions like yes/no
    # Cloning from the HTTPS link doesn't require SSH keys to be configured
    #homeshick --batch clone https://github.com/"$git_user"/"$git_repo".git
    homeshick --batch clone $git_URL
    # May need to switch back to SSH git@github.com:godmaster007/dotfiles.git
    source $HOME/.bashrc
    #source $HOME/.homesick/repos/homeshick/homeshick.sh
    
    
    ### Homeshick - Setup git config
    cd $HOME/.homesick/repos/dotfiles
    git config --global user.email "$git_email"
    git config --global user.name "$git_user"
    git remote set-url origin git@github.com:"$git_user"/"$git_repo".git
    homeshick link
    cd ~
    ;;
    
    
    1.4)
    ### Homeshick (HTTPS batch clone dotfiles to new machine)
    # "--batch" bypasses user input questions like yes/no
    # Cloning from the HTTPS link doesn't require SSH keys to be configured
    homeshick --batch clone https://github.com/"$git_user"/"$git_repo".git
    # May need to switch back to SSH git@github.com:godmaster007/dotfiles.git
    source $HOME/.bashrc
    source $HOME/.homesick/repos/homeshick/homeshick.sh
    ;;
    
    
    1.7)
    ### Repositories - Add Canonical_Partners
    sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
    ;;
    
    
    1.8)
    ### Disable Error Reporting - Remove Apport
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
    ### Edit Grub - Add nomodeset (nvidia graphics drivers causing the bootup to fail)
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"/g' /etc/default/grub
    sudo update-grub
    echo "DON'T FORGET TO REBOOT"
    ;;
    
    
    2.0)
    ### Ubuntu Essential Apps Install - Windows 10 non-gui
    for line in $(cat $HOME/bin/win_ubuntu_apps.txt); do
      sudo apt -y install $line
      if [[ ! $? -eq 0 ]]; then
        echo "Problem in apt install $line" >> output.log
      fi
    done
    ;;
    
    
    3.0)
    ### Ubuntu Essential Apps Install - installs from list
    for line in $(cat $HOME/bin/essential_apps.txt); do
      sudo apt -y install $line
      if [[ ! $? -eq 0 ]]; then
        echo "Problem in apt install $line" >> output.log
      fi
    done
    ;;
    
    
    4)
    ### Media Apps Install
    sudo DEBIAN_FRONTEND=noninteractive apt -y install libdvd-pkg
    sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure libdvd-pkg
    $INSTALL \
    ffmpeg \
    libavcodec-extra \
    vlc \
    gimp gimp-data gimp-plugin-registry gimp-data-extras \
    ;;
    
    
    5)
    ### Restricted Extras Install
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
    $INSTALL ttf-mscorefonts-installer
    echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections
    $INSTALL $FLAVOR-restricted-extras
    ;;
    
    
    6)
    ### Teamviewer Install
    wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" >> /etc/apt/sources.list.d/teamviewer.list'
    sudo sh -c 'echo "deb http://linux.teamviewer.com/deb preview main" >> /etc/apt/sources.list.d/teamviewer.list'
    sudo apt update
    yes "" | $INSTALL teamviewer
    ;;
    
    
    7)
    ### Skype Install - Non repo direct download from microsoft
    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    sudo dpkg -i skypeforlinux-64.deb
    sudo apt install -f -y
    rm -rf skypeforlinux-64.deb
    ### Snap Install
    #sudo snap install skype --classic
    ;;
    
    
    8.0)
    ### Docky Install - App Launcher
    sudo apt -y install docky
    ;;


    8.1)
    ### Plank Install - Desktop Launcher
    sudo apt -y install plank
    #Autostart Config - Create ".config/autostart/plank.desktop"
    ;;
    
    
    9)
    ### Chrome Install - Browser
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    #echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y google-chrome-stable
    ;;
    
    
    10)
    ### Thunderbird Install
    sudo apt install -y thunderbird
    ;;
    
    
    11)
    ### Plank Install - App Launcher
    sudo apt -y install plank
    ;;
    
    
    12)
    ### lm-sensors Install - Tempature Sensor
    sudo apt install -y lm-sensors hddtemp
    sudo sensors-detect
    sensors
    ;;
    
    
    13)
    ### NA
    ;;
    
    
    14)
    ### Wallpapers Download - Ubuntu Collection
    sudo apt install -y \
    ubuntu-wallpapers-* \
    edgy-wallpapers \
    feisty-wallpapers \
    gutsy-wallpapers
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
    ### Virtualbox Guest Install - Insert image before installing
    sudo apt install -y dkms build-essential
    sudo mount -r /dev/sr0 /media
    sudo sh /media/VBoxLinuxAdditions.run
    sudo adduser $USER vboxsf
    #sudo reboot now
    ;;
    
    
    17)
    ### Virtualbox Host Install - VM Software
    #Add Repo Key
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    #Add VBox Repo
    sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    #sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
    sudo apt update
    sudo apt install -y dkms gcc make linux-headers-$(uname -r)
    sudo apt install -y virtualbox-7.*
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
    # Boostnote
    #wget https://github.com/BoostIO/boost-releases/releases/download/v0.11.15/boostnote_0.11.15_amd64.deb
    wget -O boostnoteINSTALL.deb "https://github.com/BoostIO/boost-releases/releases/download/v0.12.1/boostnote_0.12.1_amd64.deb"
    sudo dpkg -i boostnoteINSTALL.deb
    #sudo dpkg -i "$(ls -t | head -n1)"
    #sudo dpkg -i boostnote_0.11.15_amd64.deb
    rm "boostnoteINSTALL.deb" -y
    #rm boostnote_0.11.15_amd64.deb
    #rm "$(ls -t | head -n1)"
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
    ### Atom Install - Text Editor
    curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt update
    sudo apt install -y atom
    ;;
    
    27)
    ### Wireshark Install - Network Monitor
    echo wireshark-common wireshark-common/install-setuid boolean true | sudo debconf-set-selections
    sudo DEBIAN_FRONTEND=noninteractive apt -y install wireshark
    sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common
    sudo adduser $USER wireshark
    ;;
    
    28)
    ### ClamAV Install - Virus Protection
    sudo apt install -y clamav clamav-daemon clamtk
    sudo freshclam
    sudo /etc/init.d/clamav-daemon start
    ;;
    
    
    28.1)
    ### ClamAV Uninstall
    sudo apt-get -y remove --purge clamav*
    ;;
    
    
    29)
    ### Youtube-dl Install - Web Downloader
    # sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
    # sudo chmod a+rx /usr/local/bin/youtube-dl
    # Pip Install - youtube-dl
    sudo apt install -y \
    curl \
    ffmpeg \
    python3-pip
    sudo -H pip3 install --upgrade youtube-dl
    ;;
    
    30)
    ### Most Install - Manpage Highlighting
    sudo apt install -y most
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
    ### Ubuntu 18.04 - Custom Tweaks
    sudo apt install \
    gnome-tweak-tool \
    gnome-shell-extensions \
    dconf-editor;
    sudo apt -y purge ubuntu-web-launchers
    ;;
    
    32)
    ### Geany Install - IDE
    sudo apt install -y geany geany-plugin-addons geany-plugin-treebrowser
    ;;
    
    33)
    ### Brackets Install - IDE
    sudo add-apt-repository ppa:webupd8team/brackets -y
    sudo apt update
    sudo apt install -y brackets
    ;;
    
    34)
    ### Bluefish Install - IDE
    sudo apt install -y bluefish bluefish-plugins
    ;;
    
    35)
    # Kali - Gnome Autologin
    #sed -i 's/#AutomaticLoginEnable = true/AutomaticLoginEnable = true/g' /etc/gdm3/daemon.conf
    #sed -i 's/#AutomaticLogin = root/AutomaticLogin = root/g' /etc/gdm3/daemon.conf
    ;;
    
    36)
    # Xfce Terminal Install - Enable dropdown terminal shortcut
    sudo apt install xfce4-terminal
    ;;
    
    37)
    ### Brave Install - Browser
    sudo apt update && sudo apt install -y apt-transport-https curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install -y brave-browser
    ;;
    
    38)
    ### ddgr Install - DuckDuckGo Command Line Search
    wget https://github.com/jarun/ddgr/archive/refs/tags/v2.2.zip
	unzip v2.2.zip
	cd ddgr-2.2/
	sudo make install
    ;;
    
    39)
    ### Vtop Install - System Monitor (To heavy for vm?)
    sudo npm -y install -g vtop
    ;;
    
    40)
    ### Libre Office Install - Office Suite
    sudo add-apt-repository ppa:libreoffice/ppa -y
    sudo apt update
    sudo apt install libreoffice
    ;;

    41)
    ### Kali 2024.2 - Enable XFCE Autologin
    #sed -i 's/#autologin-user=/autologin-user=$USER/g' /etc/lightdm/lightdm.conf
    #sed -i 's/#autologin-user-timeout=0/autologin-user-timeout=0/g' /etc/lightdm/lightdm.conf
    sed -i 's/#autologin-user=/autologin-user=root/g' /etc/lightdm/lightdm.conf
    sed -i 's/!= root quiet_success/!= anything quiet_success/g' /etc/pam.d/lightdm-autologin
    ;;
    
  esac
done
