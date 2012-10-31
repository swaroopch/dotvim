#!/usr/bin/env bash

## Check OS

if [[ "$OSTYPE" =~ "darwin" ]]
then
    export OS="mac"
elif [[ "$OSTYPE" == "linux-gnu" ]]
then
    export OS="linux"
else
    echo "Don't know what to do with '$OSTYPE' operating system"
    exit 1
fi

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

export VIM_BACKUP_DIR="/tmp/dotvim-backup"
mkdir -p $VIM_BACKUP_DIR
echo "Backing up existing vim files to $VIM_BACKUP_DIR"
for f in $(ls -a $VIM_BACKUP_DIR| grep -v '^.$' | grep -v '^..$')
do
    rm -rf "$VIM_BACKUP_DIR/$f"
done
for f in "$HOME/.vimrc" "$HOME/.gvimrc" "$HOME/.vimrc.local" "$HOME/.vim"
do
    [[ -s "$f" ]] && mv -f "$f" $VIM_BACKUP_DIR
done

echo "Ensuring backup directory exists"
mkdir -p "$HOME/.vim/backup"

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
vim +BundleInstall +qall

echo "Custom snippets"
if [[ -d "$HOME/.vim/bundle/snipmate.vim" ]]
then
    for snippet_file in $(ls snippets/*.snippets)
    do
        cat "$snippet_file"  >> "$HOME/.vim/bundle/snipmate.vim/$snippet_file"
    done
fi

echo "Custom ftplugins"
mkdir -p "$HOME/.vim/ftplugin"
for f in $(ls ftplugin/*)
do
    ln -s -f "$PWD/$f" "$HOME/.vim/ftplugin"
done

echo "Custom after plugins"
mkdir -p "$HOME/.vim/after/plugin"
for f in $(ls after/plugin/*)
do
    ln -s -f "$PWD/$f" "$HOME/.vim/after/plugin"
done

echo "Finished"
