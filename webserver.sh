# Apache Web Server installer
# Create and setup a full Apache instance to get your server up and running on the web
# Creator: ZSmith

#COLOURS
Red='\033[0;31m'	# Red
Green='\033[0;32m'	# Green
Yellow='\033[0;33m'	# Yellow
Purple='\033[0;35m'	# Purple
Cyan='\033[0;36m'	# Cyan

#Reset

Color_Off='\033[0m'	#Reset Text Colour

echo  "$Green \n Checking & installing updates.... $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade && echo "$Green [OK] $Color_Off"

## Install AMP
echo "$Green \n Installing Apache2... $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-utils apache2-dev libexpat1 ssl-cert -y && echo "$Green [OK] $Color_Off"

echo "$Green \n Installing PHP & Reqs.... $Color_Off"
sudo apt-get install libapache2-mod-php7.0 php7.0 php7.0-common php7.0-curl php7.0-dev php7.0-gd php-pear php-imagick php7.0-mcrypt php7.0-mysql && echo "$Green [OK] $Color_Off"

echo "$Green \n Installing MySQL.... $Color_Off"
sudo apt-get install mysql-server mysql-client -y && echo "$Green [OK] $Color_Off"

echo "$Green \n Installing phpMyAdmin....$Color_Off"
sudo apt-get install phpmyadmin -y && echo "$Green [OK] $Color_Off"

echo "$Green \n Verifying installs.... $Color_Off"
sudo apt-get install apache2 libapache2-mod-php7.0 php7.0 mysql-server php-pear php7.0-mysql mysql-client mysql-server php-mysql php7.0-gd -y && echo "$Green [OK] $Color_Off"


##Tweaks & Settings

#Permissions
echo "$Red Setting permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www && echo "$Green [OK] $Color_Off"
echo  "$Green Permissions have been set."

#Enable Mod Rewrite for Wordpress
echo "$Green \n Enabling Modules.... $Color_Off"
sudo a2enmod rewrite && echo "$Green [OK] $Color_Off"
sudo phpenmod mcrypt && echo "$Green [OK] $Color_Off"

#Restart Apache
echo "$Green \n Restarting Apache.... $Color_Off"
sudo service apache2 restart && echo "$Green [OK] $Color_Off"

#Installing LetsEncrypt

read -p "Would you like to install a free SSL certificate from LetsEncrypt? (Y/N)  " answer

case "$answer" in
        [Yy]* )
                yes | sudo apt-get install software-properties-common && echo "$Green [OK] $Color_Off"
                yes | sudo add-apt-repository ppa:certbot/certbot && echo "$Green [OK] $Color_Off"
                yes | sudo apt-get update && echo "$Green [OK] $Color_Off"
                yes | sudo apt-get install letsencrypt && echo "$Green [OK] $Color_Off"
                read -p "Enter Website URL: " url
                read -p "Enter Email Address: " email
                sudo letsencrypt --apache --agree-tos --email $email -d $url ;;


        [Nn]* )
                exit 0
esac

