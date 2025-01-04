#!/bin/bash
## bootstrap_dotfiles.sh ##

## Set command variables
apt="sudo apt"
if [ "$(whoami)" = "root" ]; then
    apt="apt"
fi

## Install required apps
$apt update
$apt install -y curl vim nano git xclip

## SSH Config
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -N ""
fi

# Start SSH-Agent
ssh-agent -s | grep -o '^[^ ]* [^ ]* [^ ]*' | read -r agent_pid agent_sock agent_key
export SSH_AUTH_SOCK=$agent_sock
export SSH_AGENT_PID=$agent_pid
ssh-add ~/.ssh/id_rsa

## Homeshick Config
echo -e "Hello, $USER. This script will configure your Github and SSH config.\nLeave the responses blank if you would like to use default settings."

# Default values
default_user='godmaster007'
default_email='nicholaskoron+github@gmail.com'
default_repo='dotfiles'

# Username
read -p "Enter your Github Username (ex: gituser1234) and press [ENTER]: " git_user
git_user=${git_user:-$default_user}

# Email
read -p "Enter your Github Email (ex: default@gmail.com) and press [ENTER]: " git_email
git_email=${git_email:-$default_email}

# Repo
read -p "Enter your Github Repo (ex: dotfiles) and press [ENTER]: " git_repo
git_repo=${git_repo:-$default_repo}

echo "Your github username is: $git_user"
echo "Your github email is: $git_email"
echo "Your github repo is: $git_repo"

# Set HTTPS remote origin
echo "Will set the repos remote url origin to: https://www.github.com/$git_user/$git_repo.git"

# Clone homeshick
git clone https://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"

# Add homeshick to .bashrc, enable auto completion and auto refresh
if ! grep -q 'source "$HOME/.homesick/repos/homeshick/homeshick.sh"' ~/.bashrc; then
    printf '\n# Source Homeshick\nif [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then\n  source "$HOME/.homesick/repos/homeshick/homeshick.sh"\n  # Auto Completion\n  # source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"\n  # Auto Refresh\n  homeshick refresh -q\nfi\n' >> "$HOME/.bashrc"
fi

# Clone dotfiles and configure git
homeshick --batch clone "https://github.com/godmaster007/dotfiles.git"
cd "$HOME/.homesick/repos/dotfiles" || exit
git config --global user.email "$git_email"
git config --global user.name "$git_user"
git remote set-url origin git@github.com:"$git_user"/"$git_repo".git

# Finalize
source "$HOME/.bashrc"
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick link --force

# Github SSH Config
xclip -sel clip < ~/.ssh/id_rsa.pub
echo "DON'T FORGET TO PASTE YOUR SSHKEY INTO GITHUB"
echo "Would you like to open the links for github sshkey?"
xdg-open "https://github.com/settings/ssh/new" </dev/null >/dev/null 2>&1 & disown