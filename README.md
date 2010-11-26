
# My Vim setup

# Installation

    if [[ "$OSTYPE" == "linux-gnu" ]]
    then
        sudo apt-get install git curl subversion
    elif [[ "$OSTYPE" == "darwin10.0" ]]
    then
        brew install git curl subversion
    fi

    mkdir -p "$HOME/code/"
    cd "$HOME/code/"

    git clone git://github.com/swaroopch/dotvim.git
    cd dotvim
    git submodule update --init

    bash install.bash

    vim # Follow the instructions to download the Vim plugins

    bash post_install.bash
