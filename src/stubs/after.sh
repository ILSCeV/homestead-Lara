#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

echo "\n================================"
echo "lara-vedst specific provisioning"
echo "lara-vedst: cloning git repo..."
cd /home/vagrant/Code
git clone https://github.com/4D44H/lara-vedst.git
if [ ! -d /home/vagrant/Code/lara-vedst/public ]; then
	echo "error while executing 'git clone https://github.com/4D44H/lara-vedst.git'";
	exit 1
fi
cd /home/vagrant/Code/lara-vedst

echo "\n================================"
echo "lara-vedst: database settings..."
sed -i -e 's/DB_HOST=.*/DB_HOST=localhost/' .env
sed -i -e 's/DB_DATABASE=.*/DB_DATABASE=lara/' .env
sed -i -e 's/DB_USERNAME=.*/DB_USERNAME=root/' .env
sed -i -e 's/DB_PASSWORD=.*/DB_PASSWORD=secret/' .env

echo "\n================================"
echo "lara-vedst: composer update..."
composer update

echo "\n================================"
echo "lara-vedst: seeding..."
php artisan migrate --seed

service nginx restart
echo "\n================================"
echo "lara-vedst: finished"
echo "================================"
