#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Often used tools.
$minimal_apt_get_install curl less vim-tiny psmisc dirmngr gnupg-agent
ln -s /usr/bin/vim.tiny /usr/bin/vim

## This tool runs a command as another user and sets $HOME.
cp /bd_build/bin/setuser /sbin/setuser

## This tool allows installation of apt packages with automatic cache cleanup.
cp /bd_build/bin/install_clean /sbin/install_clean

cp /bd_build/start.sh /sbin/init_start

# Install ansible & ansistrano
apt-add-repository --yes --update ppa:ansible/ansible
$minimal_apt_get_install ansible openssh-client rsync sudo
ansible-galaxy install --force ansistrano.deploy ansistrano.rollback --roles-path=/usr/share/ansible/roles

## Ansistrano user
adduser --disabled-password --gecos '' ansistrano
adduser ansistrano sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Ansistrano folder
mkdir -p /home/ansistrano/.ssh
( cd /home/ansistrano/.ssh/ && ssh-keygen -t rsa -b 4096 -C '' -f /home/ansistrano/.ssh/id_rsa )
chown ansistrano:ansistrano -Rf /home/ansistrano/

