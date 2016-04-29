#!/bin/bash

if [[ "$1" == "" ]]; then
    echo "Usage: air.sh <hostname>"
    exit -1
fi

set -e

SRC_DIRECTORY="$HOME/src"
LIB_DIRECTORY="$HOME/lib"
ANSIBLE_DIRECTORY="$LIB_DIRECTORY/ansible"
ANSIBLE_PLAYBOOKS_DIRECTORY=$(pwd)

mkdir -p $SRC_DIRECTORY

source ${ANSIBLE_PLAYBOOKS_DIRECTORY}/bootstrap.d/pyenv
source ${ANSIBLE_PLAYBOOKS_DIRECTORY}/bootstrap.d/ansible
source ${ANSIBLE_PLAYBOOKS_DIRECTORY}/bootstrap.d/ansible-playbooks

echo "Provision with Ansible"
cd $ANSIBLE_PLAYBOOKS_DIRECTORY
ansible-playbook debian.yml -e "hostname=$1"
