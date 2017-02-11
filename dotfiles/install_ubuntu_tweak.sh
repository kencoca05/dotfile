echo '------------- install ubuntu tweak ------------------'
sudo dpkg -i ~/Downloads/ubuntu-tweak_0.8.7-1~getdeb2~xenial_all.deb
sudo apt-get -f install
echo '------------- download themes for ubuntu 16.04 -----------'
sudo add-apt-repository ppa:ravefinity-project/ppa
sudo apt-get update
sudo apt-get install ambiance-colors radiance-colors
echo '------------- download icons for ubuntu 16.04 ------------'
sudo add-apt-repository ppa:numix/ppa -y
sudo apt-get update
sudo apt-get install numix-gtk-theme numix-icon-theme-circle -y
echo '------------- completed setting theme ---------------------'
echo '-----------------------------------------------------------'
