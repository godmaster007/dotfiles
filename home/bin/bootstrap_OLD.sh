#!/bin/bash

## bootstrap_V1.sh ##

## Debug ##
#set -v
#set -e
#set -x

## Run Bootstrap Commands ##
# Install Curl
# sudo apt -y install curl

# Unshorted Link
# https://raw.githubusercontent.com/godmaster007/dotfiles/master/home/bin/bootstrap_dotfiles.sh

# Shortened Link
# https://git.io/fhdhf

# 1 Liner shortened
# curl -sL git.io/fhdhf | /bin/bash

# Download to file then run
# curl -sLo bootstrap.sh git.io/fhdhf && chmod +x bootstrap.sh && . bootstrap.sh

# Reference original script
# curl -sL https://gist.github.com/andsens/2913223/raw/bootstrap_homeshick.sh | tar -xzO | /bin/bash -ex
# When forking, you can get the URL from the raw (<>) button.

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
# Essential apps - Install
################################################################################
$aptget update
$aptget install -y curl vim nano git xclip
#firefox
#p7zip p7zip-full p7zip-rar
#zsh tmux

################################################################################
# SSH-Key - Config
################################################################################
# Generate new keys, use passphrase or bypass, remove <yes "" |> to set phrase
if [ -f ~/.ssh/id_rsa.pub ]; then
    echo "Public SSHkey already created"
else
    yes "" | ssh-keygen -t rsa -b 4096
fi
# Start SSH-Agent in the background
eval $(ssh-agent -s)
# Add private SSH-Key to SSH-Agent
# (-k) stores passphrase to keychain - Example (ssh-add -k ~/.ssh/id_rsa)
ssh-add ~/.ssh/id_rsa

################################################################################
# Homeshick - Install
################################################################################

# Github and SSH config
echo "Hello, "$USER".  This script will configure your Github and SSH config. \n
Leave the responses blank if you would like to use default settings."

# Username
echo -n "Enter your Github Username (ex: gituser1234) and press [ENTER]: "
read git_user

# Email
echo -n "Enter your Github Email (ex: default@gmail.com) and press [ENTER]: "
read git_email

# Repo
echo -n "Enter your Github Repo (ex: dotfiles) and press [ENTER]: "
read git_repo

# These if's test if the variable is is null (has length 0)
# This way if no input is entered it will auto setup my default config
if [ -z $git_user ]; then
    git_user='godmaster007'
elif [ -z $git_email ]; then
    git_email='default@gmail.com'
elif [ -z $git_repo ]; then
    git_repo='dotfiles'
else
    echo "Custom settings aquired"
fi

echo "Your github username is: $git_user"
echo "Your github email is: $git_email"
echo "Your github reponame is: $git_repo"
# Set SSH remote origin
#echo Will set the remote url origin of your repo to: git@github.com:$git_user/"$git_repo".git

# Set HTTPS remote origin
echo 'Will set the repos remote url origin to: https://www.github.com/"$git_user"/"$git_repo".git'

# Clone homeshick
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

# Add homeshick to .bashrc, enable auto completion and auto refresh
if grep 'source "$HOME/.homesick/repos/homeshick/homeshick.sh"' ~/.bashrc; then
    echo "Homeshick already added to .bashrc"
else
    printf '\n# Source Homeshick
    if [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then
      source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    \n# Auto Completion
    #  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
    \n# Auto Refresh
    homeshick refresh -q
    fi
    \n' >> $HOME/.bashrc
fi

source $HOME/.bashrc

################################################################################
# GIT - Config
################################################################################
# Homeshick (HTTPS batch clone dotfiles to new machine)
# "--batch" bypasses user input questions like yes/no
# Cloning from the HTTPS link doesn't require SSH keys to be configured
homeshick --batch clone "https://github.com/$git_user/dotfiles.git"
cd $HOME/.homesick/repos/dotfiles
git config --global user.email "$git_email"
git config --global user.name "$git_user"
#git remote set-url origin git@github.com:"$git_user"/dotfiles.git
# By setting url origin with https does not require pass when pulling
git remote set-url origin https://github.com/$git_user/dotfiles.git
cd ~
source $HOME/.bashrc
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick link --force

################################################################################
# Github (Add public key)
################################################################################
# Add public key to Github, copies to clipboard, then manually paste in browser
xclip -sel clip < ~/.ssh/id_rsa.pub
# Opens github ssh registration in browser
#firefox "https://github.com/settings/ssh/new"
echo "DON'T FORGET TO PASTE YOUR SSHKEY INTO GITHUB"
echo "Would you like to open the links for github sshkey?"
# Opens default browser to github sshkeys then closes terminal
xdg-open "https://github.com/settings/ssh/new" </dev/null >/dev/null 2>&1 & disown

################################################################################
# Clone public repos
################################################################################
#homeshick clone --batch robbyrussell/oh-my-zsh

################################################################################
# Set default shell to your favorite shell
################################################################################
#$chsh --shell /bin/zsh `whoami`
#echo "Log in again to start your proper shell"
