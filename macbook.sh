#!/bin/bash

set -e

SRC_DIRECTORY="$HOME/src"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
ANSIBLE_PLAYBOOKS_DIRECTORY="$SRC_DIRECTORY/ansible-playbooks"

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Install Xcode"
    xcode-select --install
fi

if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Install Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

export PATH=/usr/local/bin:$PATH

mkdir -p $SRC_DIRECTORY

if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
    echo "Install Ansible"
    git clone git://github.com/ansible/ansible.git --recursive $ANSIBLE_DIRECTORY
fi

source $ANSIBLE_DIRECTORY/hacking/env-setup > /dev/null

if [[ ! -d $ANSIBLE_PLAYBOOKS_DIRECTORY ]]; then
    echo "Install Ansible Playbooks"
    git clone git@github.com:pm5/ansible-playbooks.git $ANSIBLE_PLAYBOOKS_DIRECTORY
fi

echo "Provision with Ansible"
cd $ANSIBLE_PLAYBOOKS_DIRECTORY
ansible-playbook macbook.yml -vvvv
