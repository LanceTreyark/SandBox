#!/bin/bash
# C:\Users\treya\Desktop\GitHubRepo\0011_SandBox\killwp.sh
# Purpose: Delete wordpress in a given directory
# then reinstall it 
echo "Hello,"
echo "This script must be run as sudo. "
sleep 1
echo "Press Enter to continue..."
read -s -p ""
echo "enter the full path to the public_html directory"
read -p "ie:/var/www/pck.treyark.com/public_html/:  " wpPathToKill
read -p "Please enter the domain name to use for this site, Don't add the 'www':   " var_DomainName
echo " "
read -p "We will be creating a new database, enter the database name you would like to use:   " var_DatabaseName
echo " "
read -p "Create a Database User Name:   " var_DatabaseUserName
echo " "
read -p "Create a Database Password:   " var_DatabasePassword
echo " "
read -p "Create a uniqe table_prefix = 'wp1_':   " tablePrefix
sleep 1
echo "Here are the details you provided:"
echo " "
sleep 1
echo "1) Domain Name............$var_DomainName"
echo "2) Path to kill...........$wpPathToKill"
echo "3) Database Name..........$var_DatabaseName"
echo "4) Database User Name.....$var_DatabaseUserName"
echo "5) Database Password......$var_DatabasePassword"
echo "6) Table Prefix...........$tablePrefix"
sleep 1

sleep 1
read -p "Are these values correct? [y/n]" var_confirmationOne
echo " "

sudo ls -n $wpPathToKill
sleep 1
sudo rm -r $wpPathToKill
sudo mkdir $wpPathToKill
sudo ls -n $wpPathToKill
sleep 1
# check if the details are correct, if so echo "great!" and proceed,
if [ $var_confirmationOne == "n" ]; then
    # if not echo instructions to restart
    echo " "
    echo "If you need to modify your settings before proceeding, Press [ctrl + C] to exit, then start over."
    sleep 1
    echo " "
    echo "Press Enter to continue running the script"
    read -s -p ""
    echo "Continuing script..."
    echo " "
else
    echo "Great!"
    sleep 1
fi
echo " "
var_Date=$(date +"%m.%d.%Y")
echo "Today is $var_Date"
sleep 1
echo " "




#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Download the latest version of wordpress"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo mkdir /tmp/script3r_$var_Date
curl -o /tmp/script3r_$var_Date/wp_$var_Date.tar.gz https://wordpress.org/latest.tar.gz && cd /tmp/script3r_$var_Date && tar -xf wp_$var_Date.tar.gz && rm -r wp_$var_Date.tar.gz && cd -

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Create an .htaccess file for WP"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

touch /tmp/script3r_$var_Date/wordpress/.htaccess

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Create wp-config.php file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

cp /tmp/script3r_$var_Date/wordpress/wp-config-sample.php /tmp/script3r_$var_Date/wordpress/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1

echo " "
echo "Create wp-content upgrade directory"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo mkdir /tmp/script3r_$var_Date/wordpress/wp-content/upgrade

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Copy Wordpress files to the $var_DomainName/public_html directory"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo cp -a /tmp/script3r_$var_Date/wordpress/. /var/www/$var_DomainName/public_html

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Configure permissions for the WordPress directory"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

#sudo rm -r /tmp/script3r_$var_Date
sudo chown -R www-data:www-data /var/www/$var_DomainName/public_html

sudo find /var/www/$var_DomainName/public_html/ -type d -exec chmod 750 {} \;

sudo find /var/www/$var_DomainName/public_html/ -type f -exec chmod 640 {} \;


#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Obtain WordPress Secret Key"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Create a variable called "var_wp_key" and store the WP secret key value within it.

var_wp_key=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
echo "$var_wp_key"

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Comment out example keys"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# comment out the example keys
sudo sed -i "/AUTH_KEY/i /*" /var/www/$var_DomainName/public_html/wp-config.php

sudo sed -i "/NONCE_SALT/a */" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Add Database connection settings to the WordPress configuration file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT
sed -i "s/wp1_/$tablePrefix/" /var/www/$var_DomainName/public_html/wp-config.php
# Use sed to find and replace the text in the file
sed -i "s/database_name_here/$var_DatabaseName/" /var/www/$var_DomainName/public_html/wp-config.php
sed -i "s/username_here/$var_DatabaseUserName/" /var/www/$var_DomainName/public_html/wp-config.php
sed -i "s/password_here/$var_DatabasePassword/" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Place the new keys at the end of the file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Place the keys at the end of the file
echo "$var_wp_key" >>/var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Comment out the ending two lines of code before we replace them"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Comment out the ending two lines of code before we replace them at the bottom of the file :
sudo sed -i "/ABSPATH/i /*" /var/www/$var_DomainName/public_html/wp-config.php 

sudo sed -i "/require_once/a */" /var/www/$var_DomainName/public_html/wp-config.php 

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Add FS_Method -Direct"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Add FS_Method -Direct
sudo sed -i "/DB_COLLATE/a define('FS_METHOD', 'direct');" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Replace last two lines of code"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Replace last three lines of code
thirdToLastLine="if ( ! defined( 'ABSPATH' ) ) {"
secondToLastLine="        define( 'ABSPATH', __DIR__ . '/' ); }"
LastLine="require_once ABSPATH . 'wp-settings.php';"

echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo "$thirdToLastLine" >> /var/www/$var_DomainName/public_html/wp-config.php
echo "$secondToLastLine" >> /var/www/$var_DomainName/public_html/wp-config.php
echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo "$LastLine" >> /var/www/$var_DomainName/public_html/wp-config.php


#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Enable Website"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT
sleep 1
echo "Enabling Website"
sudo a2ensite $var_DomainName.conf

echo "Restart Apache"
sudo systemctl restart apache2
#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Remove temp files"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo rm -r /tmp/script3r_$var_Date

#-------------------------------PAUSE------------END
sleep 1
echo "This script is complete, check your site here $var_DomainName"
echo " "
echo "Press Enter to exit the script"
read -s -p ""
sleep 1
echo "Bye!"
echo " "
