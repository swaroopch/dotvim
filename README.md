
# My Vim setup

# Installation

    if [[ "$OSTYPE" =~ "linux" ]] # Assumes Ubuntu
    then
        sudo apt-get install git curl subversion
    elif [[ "$OSTYPE" =~ "darwin" ]]
    then
        brew install git curl subversion
    else
        echo "Don't know how to install packages on $OSTYPE operating system"
        exit 1
    fi

    mkdir -p "$HOME/code/"
    cd "$HOME/code/"

    git clone git://github.com/swaroopch/dotvim.git
    cd dotvim
    git submodule update --init

    bash install.bash

    vim # Follow the instructions to download the Vim plugins

    bash post_install.bash
