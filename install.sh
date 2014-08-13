#!/usr/bin/env bash

echo "___ Howdy, Nico. Let's install these motherfuckers. Installing now. ___"

echo "___Updating packages list___"
sudo apt-get update

echo "___Configuring MySQL's default password___"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'

echo "___Installing base packages like (vim, curl, git)___"
sudo apt-get install -y vim curl python-software-properties git-core

echo "___Updating packages list once again___"
sudo apt-get update

echo "___You want the latest PHP version, right motherfucker ?___"
sudo add-apt-repository -y ppa:ondrej/php5

echo "___Updating packages list once again and again___"
sudo apt-get update

echo "___Installing the latest PHP version. including some packages___"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql

echo "___Installing and configuring XDebug___"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream = 1
xdebug.cli_color = 1
xdebug.show_local_vars = 1
EOF

echo "___Enabling mod-rewrite____"
sudo a2enmod rewrite

echo "___Setting document root to public directory___"
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www #You can change "/vagrant/public" if you want to..

echo "___I'm gonna turn on the error reporting of PHP, No you're not a pro bitch___"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

echo "___Reloading Apache Configuration___"
sudo service apache2 restart

echo "__Installing PHP dependency manager. Yeah you're right!. It's Composer!___"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#Laravel related script/packages here.
echo "__Development environment is ready. Happy Coding, bitch!___"