#!/usr/bin/env bash

homesteadRoot=~/.homestead

mkdir -p "$homesteadRoot"

cp -i src/stubs/Homestead.yaml "$homesteadRoot/Homestead.yaml"
cp -i src/stubs/after.sh "$homesteadRoot/after.sh"
cp -i src/stubs/aliases "$homesteadRoot/aliases"

REPO="https://github.com/ILSCeV/Lara.git"
read -p "Which repository do you want to work in? [$REPO] " input
REPO=${input:-$REPO}

BRANCH="develop"
read -p "Which branch do you want to work on? [$BRANCH] " input
BRANCH=${input:-$BRANCH}

sed -i'.bak' -e "s@REPOSITORY_URL_HERE@$REPO@g" "$homesteadRoot/after.sh"
sed -i'.bak' -e "s@BRANCH_NAME_HERE@$BRANCH@g" "$homesteadRoot/after.sh"

read -p "Do you want to execute 'vagrant up' now? [y/N] " input
if [ "$input" == "y" ]
then
	vagrant up
fi
