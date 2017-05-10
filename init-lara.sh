#!/usr/bin/env bash

cp -i resources/Homestead.yaml Homestead.yaml
cp -i resources/after.sh after.sh
cp -i resources/aliases aliases

REPO="https://github.com/ILSCeV/Lara.git"
read -p "Which repository do you want to work in? [$REPO] " input
REPO=${input:-$REPO}

echo ""
echo "List of available remote branches (ignore 'refs/heads/'):"
git ls-remote --heads "$REPO"
echo ""

BRANCH="master"
read -p "Which branch do you want to work on? [$BRANCH] " input
BRANCH=${input:-$BRANCH}
BRANCH="${BRANCH#refs/heads/}"

sed -i'.bak' -e "s@REPOSITORY_URL_HERE@$REPO@g" after.sh
sed -i'.bak' -e "s@BRANCH_NAME_HERE@$BRANCH@g" after.sh

read -p "Do you want to execute 'vagrant up' now? [y/N] " input
if [ "$input" == "y" ]; then
    vagrant up
fi
