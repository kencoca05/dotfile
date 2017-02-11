echo "---------------- installing apache2 -----------------"
sudo apt-get install apache2
echo "---------------- installing mysql -------------------"
sudo apt-get install mysql-server
sudo mysql_secure_installation
echo "---------------- installing php ---------------------"
sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.0 libapache2-mod-php7.0 php7.0-mbstring php7.0-zip php7.0-xml php7.0-mysql php7.0-curl php7.0-mcrypt php7.0-gd
echo "---------------- install composer -------------------"
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo "---------------- composer global require ------------"
sudo chown -R $USER:$USER /home/$USER/.composer
composer global require "laravel/installer"
echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
echo "-------------------- restart apache2 restart --------------"
sudo service apache2 restart
