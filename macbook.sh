#!/bin/bash

if [[ "$1" == "" ]]; then
    echo "Usage: macbook.sh <hostname>"
    exit -1
fi

set -e

SRC_DIRECTORY="$HOME/src"
LIB_DIRECTORY="$HOME/lib"
ANSIBLE_DIRECTORY="$LIB_DIRECTORY/ansible"
ANSIBLE_PLAYBOOKS_DIRECTORY="$SRC_DIRECTORY/ansible-playbooks"

mkdir -p $SRC_DIRECTORY

source ./bootstrap.d/xcode
source ./bootstrap.d/homebrew
source ./bootstrap.d/pyenv
source ./bootstrap.d/ansible
source ./bootstrap.d/ansible-playbooks

echo "Provision with Ansible"
cd $ANSIBLE_PLAYBOOKS_DIRECTORY
ansible-playbook macbook.yml --ask-become-pass -v -e "hostname=$1"
