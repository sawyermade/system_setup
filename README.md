# System Setup with ZSH & OMZ
## Clone and setup
```bash
git clone git@github.com:sawyermade/system_setup.git ~/.system_setup
cd ~/.system_setup
bash setup.sh
```
Place passphrase for key in ssh_add.exp in the send command: send "PASSWORD\n"

Now exit the shell twice, log back in and it should be all setup!

## Install apt packages
```bash
cd ~/.system_setup
bash apt_installs.sh
```

## Keys
```bash
git clone --recurse-submodules git@github.com:sawyermade/system_setup.git ~/.system_setup
```
Example [keys/ssh_config](EXAMPLE-ssh_config) and [keys/ssh_add.exp](EXAMPLE-ssh_add.exp)

### system_setup/keys/ tree
```
keys
├── id_pub_github
├── id_pub_server1
├── id_rsa_github
├── id_rsa_server1
├── ssh_add.exp
└── ssh_config
```

## Create Your Key Submodule
https://www.vogella.com/tutorials/GitSubmodules/article.html#creating-repositories-with-submodules
