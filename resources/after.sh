#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

echo "\n================================"
echo "Lara specific provisioning"

#echo "\n================================"
#echo "Lara: Ubuntu System Update..."
#apt-get update
#apt-get upgrade -y

echo "Lara: cloning git repo..."
cd /home/vagrant/Code
rm -rf Lara
git clone --branch BRANCH_NAME_HERE REPOSITORY_URL_HERE
if [ ! -d /home/vagrant/Code/Lara/public ]; then
	echo "Error while executing 'git clone ...'"
	exit 1
fi
cd Lara

echo "\n================================"
echo "Lara: git revisioninfo hooks setup..."
hookfile="git-create-revisioninfo-hook.sh"
if [ -f $hookfile ]; then
	cp $hookfile .git/hooks/post-commit
	cp $hookfile .git/hooks/post-checkout
	cp $hookfile .git/hooks/post-merge
	chmod +x .git/hooks/post-*
else
   echo "The file '$hookfile' was not found..."
fi
# this step is needed to trigger hook execution
git checkout --quiet BRANCH_NAME_HERE

echo "\n================================"
echo "Lara: database settings..."
cp .env.example .env
sed -i -e 's/DB_HOST=.*/DB_HOST=localhost/' .env
sed -i -e 's/DB_DATABASE=.*/DB_DATABASE=lara/' .env
sed -i -e 's/DB_USERNAME=.*/DB_USERNAME=homestead/' .env
sed -i -e 's/DB_PASSWORD=.*/DB_PASSWORD=secret/' .env

echo "\n================================"
echo "Lara: composer..."
composer install --no-progress
#composer update

echo "\n================================"
echo "Lara: installing npm dependencies (this could take some time)..."
npm install
echo "Lara: building typescript and javascript dependencies..."
npm run dev

echo "\n================================"
echo "Lara: seeding..."
php artisan migrate --seed

echo "\n================================"
echo "Lara: generate random cipher key..."
php artisan key:generate

echo "\n================================"
echo "Lara: webserver restart..."
sudo service nginx restart

#echo "\n================================"
#echo "Lara: OpenLDAP setup..."
#apt-get install -y slapd ldap-utils
#dpkg-reconfigure slapd
#apt-get install phpldapadmin
#echo "\n================================"
#echo "Lara: ApacheDS setup..."
#wget http://mirror.yannic-bonenberger.com/apache//directory/apacheds/dist/2.0.0-M21/apacheds-2.0.0-M21-amd64.deb
#dpkg -i apacheds-*-amd64.deb
#echo "\n================================"
#echo "Lara: phpmyadmin..."
#add-apt-repository -y ppa:nijel/phpmyadmin
#apt-get update
#apt-get install phpmyadmin

echo "\n================================"
echo "Lara: finished"
echo "hack: ssh://vagrant:vagrant@localhost:2222"
echo "code: C:\your-path-to-homestead-folder\Code\Lara"
echo "enjoy: http://localhost:8000"
echo "================================"
