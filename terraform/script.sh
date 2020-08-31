#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

yum -y  update
yum -y install python3-pip
pip3 install flask
python3 /tmp/app.py &
exit 0