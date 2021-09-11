#!/bin/bash
# Please do not remove this line. This command tells bash to stop executing on first error. 
set -e

echo -e '\e[42mUpdating system\e[0m'
apt update -y
echo -e '\e[42mInstalling LAMP\e[0m'
apt install lamp-server^ -y

echo -e '\e[42mCreating a database for wordpress\e[0m'
mysql -u root -p -e "CREATE DATABASE wordpressdb;"
echo -e '\e[42mSetting user and password\e[0m'
mysql -u root -p -e "CREATE USER wordpressuser@localhost IDENTIFIED BY 'wordpress';"
echo -e '\e[42mSetting access for the user database\e[0m'
mysql -u root -p -e "GRANT ALL PRIVILEGES ON wordpressdb.* TO wordpressuser@localhost;"
mysql -u root -p -e "FLUSH PRIVILEGES;"

echo -e '\e[42mInstalling and setting wordpress\e[0m'
cd /tmp
wget http://wordpress.org/latest.zip
unzip -q latest.zip -d /var/www/html
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
sudo mkdir -p /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads



