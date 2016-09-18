#!/usr/bin/env bash

git clone git://github.com/ansible/ansible.git --recursive
cd ./ansible
source ./hacking/env-setup

if [ -r ~/.ssh/id_rsa ]; then
    ssh-agent bash
    ssh-add ~/.ssh/id_rsa
fi

exit 0
