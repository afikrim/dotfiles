#!/usr/bin/env sh

function backup-dotfile() {
    if ! [ -z "$1" ]
    then
        dotname=$HOME/.$1
        if ! [ -f "$dotname" ]
        then
            if ! [ -d "$dotname" ]
            then
                echo "$dotname not exist"
                return
            fi
        fi
    else
        echo "Please add dotfile name"
        return
    fi

    if ! [ -z "$2" ]
    then
        destname=$2/$1
        if ! [ -d "$2" ]
        then
            echo "$2 not exist"
            return
        fi
    else
        echo "Please add destination name"
        return
    fi

    echo "Moving .$1 to $2"
    mv -f $dotname $destname
    echo "Create symlink $destname to $dotname"
    ln -sf $destname $dotname
}

function restore-dotfile() {
    if ! [ -z "$1" ]
    then
        dotname=$PWD/$1
        if ! [ -f "$dotname" ]
        then
            if ! [ -d "$dotname" ]
            then
                echo "$dotname not exist"
                return
            fi
        fi
    else
        echo "Please add dotfile in your backup directory"
        return
    fi

    dotfilePath=($(echo $dotname | tr "/" "\n"))

    echo "Create symlink $dotname to $HOME/.$dotfilePath[-1]"
    ln -sf $dotname $HOME/.$dotfilePath[-1]
}

function remove-dotfile() {
    if ! [ -z "$1" ]
    then
        dotname=$PWD/$1
        if ! [ -f "$dotname" ]
        then
            if ! [ -d "$dotname" ]
            then
                echo "$dotname not exist"
                return
            fi
        fi
    else
        echo "Please add dotfile in your backup directory"
        return
    fi

    dotfilePath=($(echo $dotname | tr "/" "\n"))

    echo "Remove symlink for $HOME/.$dotfilePath[-1]"
    unlink $HOME/.$dotfilePath[-1]
    echo "Move $dotname to $HOME/.$dotfilePath[-1]"
    mv $dotname $HOME/.$dotfilePath[-1]
}
