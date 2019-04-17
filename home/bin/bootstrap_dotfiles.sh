#!/bin/bash -vex


################################################################################
# Run Bootstrap
################################################################################
# Install Curl
# sudo apt -y install curl

# Unshorted Link
# https://raw.githubusercontent.com/godmaster007/dotfiles/master/home/bin/bootstrap_dotfiles.sh

# 1 Liner shortened
# curl -sL git.io/fjYMZ | /bin/bash

# Download to file then run
# curl -sLo bootstrap.sh git.io/fjYMZ && chmod +x bootstrap.sh && . bootstrap.sh

# Reference original script
# curl -sL https://gist.github.com/andsens/2913223/raw/bootstrap_homeshick.sh | tar -xzO | /bin/bash -ex
# When forking, you can get the URL from the raw (<>) button.


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
	git_repo='dotfiles.git'
fi

echo Your github username is: $git_user
echo Your github email is: $git_email
echo Your github reponame is: $git_repo
echo Will set the remote url origin of your repo to: git@github.com:$git_user/$git_repo


################################################################################
# Set command variables depending on root admin
# This assumes you use a debian derivate, replace with yum, pacman etc.
################################################################################
aptget='sudo apt-get'
chsh='sudo chsh'
if [ `whoami` = 'root' ]; then
	aptget='apt-get'
	chsh='chsh'
fi


################################################################################
# Install essential apps
################################################################################
$aptget update
$aptget install -y vim nano git xclip
#firefox
#p7zip p7zip-full p7zip-rar
#zsh tmux


################################################################################
# Install homeshick (Adding another machine)
################################################################################
if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
	git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
	source $HOME/.homesick/repos/homeshick/homeshick.sh
fi


################################################################################
# Github Config - Custom Dotfiles
################################################################################
#Clone using batch to bypasses user input questions
#homeshick --batch clone git@github.com:godmaster007/dotfiles.git
# Changed to the https so it doesn't require authorization to clone
homeshick --batch clone https://github.com/"$git_user"/"$git_repo"
# Setup login identity for seamless updates and editing
homeshick cd dotfiles
git config --global user.email "$git_email"
git config --global user.name "$git_user"
git remote set-url origin git@github.com:"$git_user"/"$git_repo"
cd ~
# Link all files to $HOME
homeshick link --force


################################################################################
# SSH-Key Config + Add pub key to github
################################################################################
# Generate new keys, use passphrase or bypass, remove <yes "" |> to set phrase
yes "" | ssh-keygen -t rsa -b 4096
# Start SSH-Agent in the background
eval $(ssh-agent -s)
# Add private SSH-Key to SSH-Agent "-k" stores passphrase to keychain
# Example with -k: "ssh-add -k ~/.ssh/id_rsa"
ssh-add ~/.ssh/id_rsa
# Add public key to Github, copies to clipboard, then manually paste in browser
xclip -sel clip < ~/.ssh/id_rsa.pub
# Opens github ssh registration in browser
#firefox "https://github.com/settings/ssh/new"
xdg-open "https://github.com/settings/ssh/new"


##########################
# Clone public repos
##########################
#homeshick clone --batch robbyrussell/oh-my-zsh


################################################
# Set default shell to your favorite shell
################################################
#$chsh --shell /bin/zsh `whoami`
echo "Log in again to start your proper shell"


##########################################
# Show git config status remind user to reboot for settings to take affect
##########################################
cd $HOME/.homesick/repos/dotfiles
git config -l
cd ~
echo "sudo reboot -h now"
