#!/bin/bash

# Local variables
temp_codename=$(lsb_release -cs)
temp_cuda_ver="10.1"
temp_cwd=$(pwd)

# Adds sublime text repo
if [ ! -f /etc/apt/sources.list.d/sublime-text.list ]
then 
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi

# Adds google chrome repo
if [ ! -f /etc/apt/sources.list.d/google-chrome.list ]
then 
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
fi

# Adds ros-latest
if [ ! -f /etc/apt/sources.list.d/ros-latest.list ]
then 
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
fi

# Adds realsense2
if [ ! -f /etc/apt/sources.list.d/realsense2.list ]
then 
	sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
	echo "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo $temp_codename main" | sudo tee /etc/apt/sources.list.d/realsense2.list
fi

# Adds unetbootin repo
if [ ! -f /etc/apt/sources.list.d/gezakovacs-ubuntu-ppa-${temp_codename}.list ]
then 
	sudo add-apt-repository ppa:gezakovacs/ppa
fi

# Flatpak Repo
# Adds unetbootin repo
if [ ! -f /etc/apt/sources.list.d/alexlarsson-ubuntu-flatpak-${temp_codename}.list ]
then 
	sudo add-apt-repository ppa:alexlarsson/flatpak
fi

# PPA Manager
sudo add-apt-repository ppa:webupd8team/y-ppa-manager

# Etcher
if [ ! -f /etc/apt/sources.list.d/balena-etcher.list ]
then 
	echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
fi

# Installs apt packages
sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y
sudo apt install git zsh expect build-essential openssh-server libopencv-dev libopencv-contrib-dev python3 python3-pip libboost-all-dev curl mc tmux sshpass screen tree unrar apt-transport-https sublime-text htop glances filezilla hexchat evolution virt-manager qemu gnome-tweaks chrome-gnome-shell nemo qbittorrent vim vlc discord steam gparted gimp obs-studio youtube-dl imagemagick snapd slack-desktop google-chrome-stable samba openjdk-11-jdk calibre y-ppa-manager sysfsutils unetbootin gnome-shell-extension-appindicator pwgen aptitude kdenlive fail2ban powertop weka qemu-kvm pavucontrol neofetch spotify-client balena-etcher-electron rar -y

# Xbox One Controller
#sudo apt install sysfsutils -y && echo  "/module/bluetooth/parameters/disable_ertm=1" | sudo tee /etc/sysfs.conf && sudo systemctl restart sysfsutils.service

# Pulse
# sudo apt install libwebkitgtk-1.0-0 -y
# sudo dpkg -i ps-pulse.deb

# Installs flatpak packages
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# sudo flatpak install spotify -y
#sudo apt install spotify-client -y
#flatpak install skype -y

# Installs ros
read -p 'Install ROS? [Y/n]: ' temp_install_ros
if [ $temp_install_ros == 'Y' ] || [ $temp_install_ros == 'y' ]
then
	sudo apt install ros-melodic-desktop-full -y
	sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
fi

# Realsense2
read -p 'Install realsense2? [Y/n]: ' temp_install_rs
if [ $temp_install_rs == 'Y' ] || [ $temp_install_rs == 'y' ]
then
	sudo apt install librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg -y
fi

# Cuda if Pop!_OS Nvidia version, fails for everything else
# read -p 'Install Cuda Nvidia? [Y/n]: ' temp_install_cuda
# if [ $temp_install_cuda == 'Y' ] || [ $temp_install_cuda == 'y' ]
# then
# 	sudo cp cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
# 	sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
# 	sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
# 	sudo apt-get update
# 	sudo apt install cuda -y
# fi
# read -p 'Install Cuda System76? [Y/n]: ' temp_install_cuda
# if [ $temp_install_cuda == 'Y' ] || [ $temp_install_cuda == 'y' ]
# then
# 	# sudo apt install system76-cuda-$temp_cuda_ver system76-cudnn-$temp_cuda_ver -y
# 	sudo apt install system76-cuda-latest -y
# fi

# Installs conda
read -p 'Install Anaconda 3? [Y/n]: ' temp_install_conda
if [ $temp_install_conda == 'Y' ] || [ $temp_install_conda == 'y' ]
then
	temp_conda_fname="Anaconda3-2019.10-Linux-x86_64.sh"
	wget https://repo.anaconda.com/archive/${temp_conda_fname}

	read -p 'Install System-wide? [Y/n]: ' temp_install_conda
	if [ $temp_install_conda == 'Y' ] || [ $temp_install_conda == 'y' ]
	then
		sudo bash ./${temp_conda_fname}
	else
		bash ./${temp_conda_fname}
	fi

	rm -f ./${temp_conda_fname}
fi

# Install TLP for laptop
read -p 'Install TLP? [Y/n]: ' temp_install_tlp
if [ $temp_install_tlp == 'Y' ] || [ $temp_install_tlp == 'y' ]
then
	sudo apt install tlp -y
fi

# Install AppImageLauncher
read -p 'Install AppImageLauncher? [Y/n]: ' temp_install_ail
if [ $temp_install_ail == 'Y' ] || [ $temp_install_ail == 'y' ]
then
	sudo dpkg -i appimagelauncher_2.1.1-travis931.f6d5926.bionic_amd64.deb
fi

# Install Global Protect VPN
read -p 'Install Global Protect? [Y/n]: ' temp_install_gp
if [ $temp_install_gp == 'Y' ] || [ $temp_install_gp == 'y' ]
then
	sudo dpkg -i GlobalProtect_deb-5.1.1.0-17.deb
fi

# Install C410 Drivers
read -p 'Install C410? [Y/n]: ' temp_install_gp
if [ $temp_install_gp == 'Y' ] || [ $temp_install_gp == 'y' ]
then
	cd c410
	tar zxf uld_V1.00.39_01.17.tar.gz
	sudo uld/install.sh
	rm -rf uld
	cd $temp_cwd
fi

# What needs to be installed
# echo -e "\nFollowing packages must be manually installed:"
# echo "1. cuda  *if not on pop!_os"

# Launches gnome extensions
echo -e "\nEnable Ubuntu appindicators"
gnome-shell-extension-prefs &
