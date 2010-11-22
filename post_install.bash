#!/usr/bin/env bash

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

## Post Installation

if [[ -d "$DOTVIM/snipMate" ]]
then
    # FIXME Ugly but don't know how else to include custom snippets
    cat "$DOTVIM/snippets_more/eruby.snippets" >> "$DOTVIM/snipMate/snippets/eruby.snippets"
    cat "$DOTVIM/snippets_more/ruby.snippets" >> "$DOTVIM/snipMate/snippets/ruby.snippets"
    cat "$DOTVIM/snippets_more/python.snippets" >> "$DOTVIM/snipMate/snippets/python.snippets"
    cat "$DOTVIM/snippets_more/htmljinja.snippets" >> "$DOTVIM/snipMate/snippets/htmljinja.snippets"
fi

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

# command-t
cd $DOTVIM/Command-T/ruby/command-t
ruby extconf.rb
make

## Custom files

# Put swap files in a specific location, to avoid Dropbox from spinning incessantly.
mkdir -p "$HOME/.vim/swapfiles/"

# HACK for htmljinja
mkdir -p "$HOME/.vim/syntax/"
ln -s -i "$DOTVIM/htmljinja/htmljinja.vim" "$HOME/.vim/syntax/htmljinja.vim"
mkdir -p "$HOME/.vim/ftplugin/"
ln -s -i "$DOTVIM/htmljinja/htmldjango.vim" "$HOME/.vim/ftplugin/htmldjango.vim"
ln -s -i "$DOTVIM/htmljinja/htmldjango.vim" "$HOME/.vim/ftplugin/html.vim"

## Cleanup

if [[ "$OS" == "mac" ]]
then
    brew cleanup
fi

unset OS

echo "Finished. Open Vim now!"
