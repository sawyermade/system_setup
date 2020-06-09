#!/bin/bash
sudo cp gpu-lock.sh /usr/bin/gpu-lock
sudo chmod +x /usr/bin/gpu-lock
echo "@reboot root cd / && /usr/bin/gpu-lock" | sudo tee -a /etc/crontab
