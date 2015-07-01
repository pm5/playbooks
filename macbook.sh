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

if [[ ! -d $HOME/.pyenv ]]; then
    echo "Install pyenv"
    git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install -v 2.7.10
    pyenv global 2.7.10
fi

export PATH=/usr/local/bin:$PATH

mkdir -p $SRC_DIRECTORY

if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
    echo "Install Ansible"
    git clone git://github.com/ansible/ansible.git --recursive $ANSIBLE_DIRECTORY
    cd $ANSIBLE_DIRECTORY
    pip install six paramiko PyYAML Jinja2 httplib2
fi

source $ANSIBLE_DIRECTORY/hacking/env-setup > /dev/null

if [[ ! -d $ANSIBLE_PLAYBOOKS_DIRECTORY ]]; then
    echo "Install Ansible Playbooks"
    git clone git@github.com:pm5/ansible-playbooks.git $ANSIBLE_PLAYBOOKS_DIRECTORY
fi

echo "Provision with Ansible"
cd $ANSIBLE_PLAYBOOKS_DIRECTORY
ansible-playbook macbook.yml -v
