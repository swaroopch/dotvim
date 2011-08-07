#!/usr/bin/env bash

# Git and Curl required
if [[ $(which git) == "" ]]
then
    echo "Install git ( http://git-scm.com ) first"
    exit 1
fi
if [[ $(which curl) == "" ]]
then
    echo "Install curl ( http://curl.haxx.se ) first"
    exit 1
fi

#rm -rf ~/.vimrc ~/.gvimrc  ~/.vimrc.local ~/.vim

# Download Vundle
mkdir -p ~/.vim/bundle
if [[ ! -d ~/.vim/bundle/vundle ]]
then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

# Download upstart.vim
if [[ ! -f ~/.vim/syntax/upstart.vim ]]
then
    mkdir -p ~/.vim/syntax/
    curl http://bazaar.launchpad.net/~upstart-devel/upstart/trunk/download/head:/upstart.vim-20090708195914-1n7k3bcwobwm4ag7-7/upstart.vim -o ~/.vim/syntax/upstart.vim
fi

# Link vimrc, gvimrc
ln -s -f "$PWD/vimrc" "$HOME/.vimrc"
ln -s -f "$PWD/gvimrc" "$HOME/.gvimrc"
if [[ -f "$PWD/vimrc.local" ]]
then
    ln -s -f "$PWD/vimrc.local" "$HOME/.vimrc.local"
fi

# Tell Vundle to download all the scripts
vim -c "BundleInstall" -c "quit"

# Command-T post-download installation
if [[ -d ~/.vim/bundle/command-t ]]
then
    cd ~/.vim/bundle/command-t
    rake make
    cd -
fi

# Custom snippets
if [[ -d ~/.vim/bundle/snipmate.vim ]]
then
    cat snippets/eruby.snippets  >> ~/.vim/bundle/snipmate.vim/snippets/eruby.snippets
    cat snippets/python.snippets >> ~/.vim/bundle/snipmate.vim/snippets/python.snippets
fi

# Jinja post-download installation
if [[ -d ~/.vim/bundle/Jinja ]] && [[ ! -f ~/.vim/bundle/Jinja/syntax/htmljinja.vim ]]
then
    curl http://www.vim.org/scripts/download_script.php?src_id=6961 -o ~/.vim/bundle/Jinja/syntax/htmljinja.vim
fi

# Remove explicit Safari mention
if [[ -d ~/.vim/bundle/Textile-for-VIM/ ]]
then
    sed -i.bak 's/open -a Safari/open/' "$HOME/.vim/bundle/Textile-for-VIM/ftplugin/textile.vim"
fi

echo "Finished"
