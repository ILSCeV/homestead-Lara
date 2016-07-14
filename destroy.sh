#!/usr/bin/env bash

homesteadRoot=~/.homestead

read -p "Are you sure you want to destroy the VM and delete created files? [y/N] " input 
if [ "$input" != "y" ]
then
	exit 1
fi

vagrant destroy -f
echo "==> Deleting files and folders..."
rm -rfv "Code/lara-vedst"
rm -rfv "$homesteadRoot"
rm -rfv ".vagrant"

