#!/bin/bash
function adduser_data {
   if [ -n "$1" ] 
      then
         echo "arg1: $1"
         temp_new_user="$1"
      else
         echo -n "Enter new username: "
         read temp_new_user
   fi

   # echo "temp_new_user: $temp_new_user"
   temp_data_dir=/data
   temp_user_data_dir=$temp_data_dir/$temp_new_user
   temp_datasets_dir=$temp_data_dir/datasets
   temp_home_dir=/home/$temp_new_user

   sudo adduser $temp_new_user
   sudo adduser $temp_new_user
   sudo mkdir -p $temp_user_data_dir
   sudo chown -R $temp_new_user $temp_user_data_dir
   sudo chmod -R 2755 $temp_user_data_dir

   sudo ln -s $temp_user_data_dir $temp_home_dir/data
   sudo chown -h $temp_new_user:$temp_new_user $temp_home_dir/data

   sudo ln -s $temp_datasets_dir $temp_home_dir/datasets
   sudo chown -h $temp_new_user:$temp_new_user $temp_home_dir/datasets 
}

function create_data_datasets {
   if [ ! -d /data ]
   then
      sudo groupadd data
      sudo mkdir /data
      sudo chgrp -R data /data
      sudo chmod -R 2775 /data
      sudo adduser $USER data
   fi

   if [ ! -d /data/datasets ]
   then
      sudo groupadd datasets
      sudo mkdir /data/datasets
      sudo chgrp -R datasets /data/datasets
      sudo chmod -R 2775 /data/datasets
      sudo adduser $USER datasets
   fi
}

alias adduserdata='adduser_data'

alias createdata='create_data_datasets'
