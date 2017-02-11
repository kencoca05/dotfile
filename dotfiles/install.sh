if [ ! -d "~/dotfile" ]; then
    cd ../..
    cp dotfile -R ~
fi
sh install_vim_git_ssh.sh
sh install_bash_powerline.sh
sh install_lamp_laravel.sh
sh install_ubuntu_tweak.sh
