#!/bin/bash
temp_ai_dir="$HOME/AppImage"
# echo $temp_ai_dir

# Creates temp install directory
temp_install="$temp_ai_dir/temp_install"
mkdir -p $temp_install
# echo $temp_install

# Downloads AppImage
temp_url="$1"
wget -P $temp_install $temp_url

# Unzips if needed
if [ ${temp_url: -4} == ".zip" ]
then
	unzip ${temp_install}/*.zip -d ${temp_install}
fi

# Copies to A
mv ${temp_install}/*.AppImage ${temp_ai_dir}/
rm -rf $temp_install

# Changes permissions
chmod +x -R $temp_ai_dir

# Done
echo -e "\nInstalled: $1"