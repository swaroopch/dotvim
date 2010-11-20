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
else
    cd $DOTVIM
    git pull
fi

## Install vim files

echo "Installing vimrc"
ln -s -f "$DOTVIM/vimrc" "$HOME/.vimrc"

echo "Going to open Vim now, keep pressing 'y' and return key until done."
vim "$DOTVIM/README.md"

## Install dependencies

# ack
if [[ "$OS" == "linux" ]]
then
    if [[ -z $(dpkg -l | fgrep -i ack-grep) ]]
    then
        sudo apt-get install ack-grep
    fi
    sudo ln -s -f /usr/bin/ack-grep /usr/bin/ack
elif [[ "$OS" == "mac" ]]
then
    brew install ack
fi

## Cleanup

if [[ "$OS" == "mac" ]]
then
    brew cleanup
fi

unset OS

echo "Finished. Open Vim now!"
