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

	# Sets quota on users home directory
	sudo setquota -u $temp_new_user 100G 100G 0 0 /home 

	# Sets ownership and permissions for users data folder
	sudo mkdir -p $temp_user_data_dir
	sudo chown -R $temp_new_user $temp_user_data_dir
	sudo chmod -R 2755 $temp_user_data_dir

	# Sets quota for users data directory
	sudo setquota
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