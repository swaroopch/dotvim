#!/usr/bin/env bash

## Check Bash Version

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

## Check Git is installed
if [[ $(which git) == "" ]]
then
    echo "Please ensure that git is installed"
    exit 1
fi

## Check OS

if [[ "$OSTYPE" == "darwin10.0" ]]
then
    export OS="mac"
    if [[ $(which brew) == "" ]]
    then
        echo "Please install brew ( http://mxcl.github.com/homebrew ) before proceeding."
        exit 1
    fi
elif [[ "$OSTYPE" == "linux-gnu" ]]
then
    export OS="linux"
else
    echo "Don't know what to do with '$OSTYPE' operating system"
    exit 1
fi

# Assumption of directory location
DOTVIM="$HOME/code/dotvim"

if [[ ! -d "$DOTVIM" ]]
then
    mkdir -p "$DOTVIM/.."
    cd "$DOTVIM/.."
    git clone git@github.com:swaroopch/dotvim.git
    cd "$DOTVIM"
    git submodule update --init
else
    cd $DOTVIM
    git pull
fi

## Install vim files

echo "Installing vimrc"
ln -s -f "$DOTVIM/vimrc" "$HOME/.vimrc"
ln -s -f "$DOTVIM/gvimrc" "$HOME/.gvimrc"

echo "Open Vim in a separate window NOW, keep pressing 'y' and return key until Vim exits. Press enter key in this window when done."

unset OS
