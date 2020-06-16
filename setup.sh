#!/bin/bash

# zsh location on system
temp_zsh_location="/usr/bin/zsh"

# System Setup director location
temp_cwd=$(pwd)

# Checks if zshrc.sh exists
if [ ! -f ~/.zshrc ]
then
	sudo apt update
fi

# Checks if git is installed
if ! hash tmux 2>/dev/null
then
	echo "tmux not installed, installing tmux..."
	sudo apt install tmux -y
fi

# Checks if git is installed
if ! hash git 2>/dev/null
then
	echo "git not installed, installing git..."
	sudo apt install git -y
fi

# Checks if expect is installed
if ! hash expect 2>/dev/null
then
	echo "expect not installed, installing expect..."
	sudo apt install expect -y
fi

# Checks if zsh is installed
if ! hash zsh 2>/dev/null
then
	echo "zsh not installed, installing zsh..."
	sudo apt install zsh zsh-doc -y
fi

# Installs OMZ
temp_flag=1
if [ ! -d ~/.oh-my-zsh ]
then
	echo "installing omz..."
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	temp_flag=0
fi

# Creates time file if doesnt exist
function  timelast {
	date +%s > $1/time.last
}
function timediff {
	echo -n "$(($(date +%s) - $(cat $1)))"
}
[ ! -f $temp_cwd/time.last ] && timelast $temp_cwd

# Creates ~/.zshrc 
temp_eval="eval \$(ssh-agent) > /dev/null"
temp_exp="expect ${temp_cwd}/keys/ssh_add.exp > /dev/null"
temp_funcs="source ${temp_cwd}/functions.sh"
temp_alias="source ${temp_cwd}/aliases.sh"
temp_if_timelast="[ ! -f $temp_cwd/time.last ] && timelast $temp_cwd"
temp_timediff="temp_diff=\$(timediff $temp_cwd/time.last)"
temp_ip_if="wget -q --spider http://google.com; if [ \$? -eq 0 ] && [ \$temp_diff -ge 86400 ]; then"
temp_git="cd $temp_cwd > /dev/null && git pull && cd - > /dev/null"
temp_timelast="timelast $temp_cwd"
temp_setup="cd $temp_cwd > /dev/null && bash ./setup.sh && cd - > /dev/null"
temp_ip_fi="fi"
temp_zshrc="source ${temp_cwd}/zshrc.sh"
temp_openssl="export OPENSSL_CONF=${temp_cwd}/openssl.cnf"

echo "# SawyerMade" > ~/.zshrc
echo $temp_eval >> ~/.zshrc
echo $temp_exp >> ~/.zshrc
echo $temp_funcs >> ~/.zshrc
echo $temp_alias >> ~/.zshrc
echo $temp_if_timelast >> ~/.zshrc
echo $temp_timediff >> ~/.zshrc
echo $temp_ip_if >> ~/.zshrc 
echo $temp_git >> ~/.zshrc
echo $temp_timelast >> ~/.zshrc
echo $temp_setup >> ~/.zshrc
echo $temp_ip_fi >> ~/.zshrc
echo $temp_zshrc >> ~/.zshrc
echo $temp_exp >> ~/.zshrc
echo $temp_openssl >> ~/.zshrc 

# Installs conda completion
if [ ! -d ~/.oh-my-zsh/custom/plugins/conda-zsh-completion ]
then
	echo "installing conda completion..."
	git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
fi

# Checks if .ssh exists
if [ ! -d ~/.ssh ]
then
	mkdir ~/.ssh
	chmod -R 700 ~/.ssh
fi


if [ ! -d ~/.ssh/controlmasters ]
then
	mkdir ~/.ssh/controlmasters
	chmod -R 700 ~/.ssh
fi

# Install private ssh keys
cp ${temp_cwd}/keys/id_rsa* ~/.ssh/


# Checks if zsh is primary shell
if [[ ! "$SHELL" == "/usr/bin/zsh" && ! "$SHELL" == "/bin/zsh" ]] && [ $temp_flag == 1 ]
then
	echo "zsh not primary shell, changing shell..."
	chsh -s $temp_zsh_location || chsh -s "/bin/zsh"
fi

# Copies ssh_config
cp ${temp_cwd}/keys/ssh_config ~/.ssh/config

# Changes permissions to be safe
chmod -R 700 ~/.ssh > /dev/null
chmod -R 700 $temp_cwd > /dev/null

# Adds tmux config and sources it
cp ${temp_cwd}/tmux.conf ~/.tmux.conf > /dev/null
tmux new-session -d -s dump > /dev/null
tmux source-file ~/.tmux.conf > /dev/null
tmux source ~/.tmux.conf > /dev/null
tmux kill-session -t dump > /dev/null