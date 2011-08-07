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

echo "Backup existing vim files"
export VIM_BACKUP_DIR="/tmp/dotvim-backup"
mkdir -p $VIM_BACKUP_DIR
for f in $(ls -a $VIM_BACKUP_DIR| grep -v '^.$' | grep -v '^..$')
do
    rm -rf "$VIM_BACKUP_DIR/$f"
done
for f in "$HOME/.vimrc" "$HOME/.gvimrc" "$HOME/.vimrc.local" "$HOME/.vim"
do
    [[ -s "$f" ]] && mv -vf "$f" $VIM_BACKUP_DIR
done

echo "Download Vundle"
mkdir -p "$HOME/.vim/bundle"
if [[ ! -d "$HOME/.vim/bundle/vundle" ]]
then
    git clone http://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"
fi

echo "Link vimrc, gvimrc"
ln -s -f "$PWD/vimrc" "$HOME/.vimrc"
ln -s -f "$PWD/gvimrc" "$HOME/.gvimrc"
if [[ -f "$PWD/vimrc.local" ]]
then
    ln -s -f "$PWD/vimrc.local" "$HOME/.vimrc.local"
fi

echo "Instruct Vundle to download all the scripts"
vim -c "BundleInstall" -c "quit"

echo "Download upstart.vim"
if [[ ! -f $HOME/.vim/syntax/upstart.vim ]]
then
    mkdir -p $HOME/.vim/syntax/
    curl "http://bazaar.launchpad.net/~upstart-devel/upstart/trunk/download/head:/upstart.vim-20090708195914-1n7k3bcwobwm4ag7-7/upstart.vim" -o "$HOME/.vim/syntax/upstart.vim"
fi

echo "Command-T post-download installation"
if [[ -d "$HOME/.vim/bundle/command-t" ]]
then
    cd "$HOME/.vim/bundle/command-t"
    rake make
    cd -
fi

echo "Custom snippets"
if [[ -d "$HOME/.vim/bundle/snipmate.vim" ]]
then
    cat snippets/eruby.snippets  >> "$HOME/.vim/bundle/snipmate.vim/snippets/eruby.snippets"
    cat snippets/python.snippets >> "$HOME/.vim/bundle/snipmate.vim/snippets/python.snippets"
fi

echo "Jinja post-download installation"
if [[ -d "$HOME/.vim/bundle/Jinja" ]] && [[ ! -f "$HOME/.vim/bundle/Jinja/syntax/htmljinja.vim" ]]
then
    curl "http://www.vim.org/scripts/download_script.php?src_id=6961" -o "$HOME/.vim/bundle/Jinja/syntax/htmljinja.vim"
fi

echo "Remove explicit Safari mention in Textile-for-VIM"
if [[ -d "$HOME/.vim/bundle/Textile-for-VIM/" ]]
then
    sed -i.bak 's/open -a Safari/open/' "$HOME/.vim/bundle/Textile-for-VIM/ftplugin/textile.vim"
fi

echo "Finished"
