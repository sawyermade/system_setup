function adduser_hulk {
	# Get new username
	if [ -n "$1" ]
	then
		temp_new_user="$1"
	else
		echo -n "Enter new username: "
		read temp_new_user
	fi

	# Temp directories
	temp_data_dir=/data
	temp_user_data_dir=$temp_data_dir/$temp_new_user
	temp_datasets_dir=$temp_data_dir/datasets
	temp_home_dir=/home/$temp_new_user

	# Add user and add user to data group
	sudo adduser $temp_new_user
	sudo adduser $temp_new_user data
	sudo setquota -u $temp_new_user 100G 100G 0 0 /home 

	# Adds conda to bashrc
	echo "source /opt/anaconda3/etc/profile.d/conda.sh" | sudo tee -a $temp_home_dir/.bashrc
	sudo chown $temp_new_user:$temp_new_user $temp_home_dir/.bashrc

	# Sets ownership and permissions for users data folder
	sudo mkdir -p $temp_user_data_dir
	sudo chown -R $temp_new_user $temp_user_data_dir
	sudo chmod -R 2755 $temp_user_data_dir
	sudo setquota -u $temp_new_user 1000G 1000G 0 0 /data 

	# Creates sybolic links
	sudo ln -s $temp_user_data_dir $temp_home_dir/data
	sudo ln -s $temp_datasets_dir $temp_home_dir/datasets
	sudo chown -h $temp_new_user:$temp_new_user $temp_home_dir/data
	sudo chown -h $temp_new_user:$temp_new_user $temp_home_dir/datasets 
}

function create_data_datasets {
	if [ ! -d /data ]
	then
		# Create group and make dirs
		sudo groupadd data
		sudo mkdir /data
		sudo chgrp -R data /data
		sudo chmod -R 2775 /data

		# Adds myself to group
		sudo adduser $USER data
	fi

	if [ ! -d /data/datasets ]
	then
		# Create group and make dirs
		sudo groupadd datasets
		sudo mkdir /data/datasets
		sudo chgrp -R datasets /data/datasets
		sudo chmod -R 2775 /data/datasets

		# Adds myself to group
		sudo adduser $USER datasets
	fi
}

function  timelast {
	date +%s > $1/time.last
}

function timediff {
	echo -n "$(($(date +%s) - $(cat $1)))"
}

function mountsshfs {
	[ ! -d ~/mnt/$1 ] && mkdir -p ~/mnt/$1
	sshfs $1:$2 ~/mnt/$1
}

function umountsshfs {
	umount ~/mnt/$1
}