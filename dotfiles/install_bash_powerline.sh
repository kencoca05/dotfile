#!/bin/bash
echo '------------------------ config powerline for bash -----------------------'
cp ~/dotfile/dotfiles/powerline_bash.sh ~/.powerline_bash.sh
echo 'if [ -f ~/.powerline_bash.sh ]; then'  >> ~/.bashrc
echo '. ~/.powerline_bash.sh'  >> ~/.bashrc
echo 'fi' >> ~/.bashrc
. ~/.bashrc
echo '------------------------ completed -----------------------'
