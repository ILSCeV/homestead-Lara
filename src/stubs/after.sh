#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

echo "\n================================"
echo "lara-vedst specific provisioning"

echo "\n================================"
echo "lara-vedst: Ubuntu System Update..."
apt-get update
apt-get upgrade -y

echo "lara-vedst: cloning git repo..."
cd /home/vagrant/Code
rm -r lara-vedst
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

#echo "\n================================"
#echo "lara-vedst: OpenLDAP setup..."
#apt-get install -y slapd ldap-utils
#dpkg-reconfigure slapd
#apt-get install phpldapadmin
#echo "\n================================"
#echo "lara-vedst: ApacheDS setup..."
#wget http://mirror.yannic-bonenberger.com/apache//directory/apacheds/dist/2.0.0-M21/apacheds-2.0.0-M21-amd64.deb
#dpkg -i apacheds-*-amd64.deb
#echo "\n================================"
#echo "lara-vedst: phpmyadmin..."
#add-apt-repository -y ppa:nijel/phpmyadmin
#apt-get update
#apt-get install phpmyadmin

echo "\n================================"
echo "lara-vedst: finished"
echo "enjoy: http://localhost:8000"
echo "================================"
