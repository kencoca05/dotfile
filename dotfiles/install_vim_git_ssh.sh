echo ' ------------------- disable guest session ------------------- '
sudo echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
echo '\n'
echo ' ------------------- install git ------------------- '
sudo apt-get install git
echo '\n'
echo ' ------------------- generate ssh key ------------------- '
echo ' enter your email '
ssh-keygen -t rsa
echo '\n'
echo ' ------------------- install vim ------------------- '
sudo apt-get install vim
echo '\n'
git config --global core.editor "vim"
echo ' ------------------- install powerline using pip ------------------- '
sudo apt-get install python-pip
pip install -U pip
pip install --user git+git://github.com/Lokaltog/powerline
echo '\n'
echo ' ------------------- Download the latest version of Powerline font. ------------------- '
cd ~
git clone https://github.com/powerline/fonts.git 
cd ~/fonts
sh install.sh
echo '\n'
sudo fc-cache -f -v
echo '\n'
echo '-------------------- change font-size for terminal ------------------------------------'
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "ProFontIIx\ Nerd\ Font\ Book 10"
echo '\n'
echo ' ------------------- config plugin for vim ------------------- '
echo ' 1. install vundle -------'
cd ~
mkdir .vim
cd .vim
cp ~/dotfile/dotfiles/colors -R ~/.vim/
mkdir bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo ' 2. install plugin for vim'
git clone https://github.com/snowflower2804/dotfile.git
cp ~/dotfile/dotfiles/vimrc ~/.vimrc
vim +PluginInstall +qall


