#!/usr/bin/env bash

# link subfile of the dir start with @. 
# like @abc/def/eg
# link ~/.adc/def/eg -> @abc/def/eg
function link_dir_file {
    DIR=$1
    if [ -d "$DIR" ]; then
        for i in $DIR/*
        do
            link_dir_file $i
        done
    else
        file=$DIR
        source="${PWD}/$file"
        target="${HOME}/${file/@/.}"
        if [ -e "${target}" ]; then
            mv $target $target.bak
        else
            mkdir -p $(dirname $target)
        fi
        ln -sf ${source} ${target}
    fi
    return
}

for i in @*
do
    link_dir_file $i
done
exit

# 
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        rm $target.bak
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

if [ "$1" = "vim" ]; then
    for i in _vim*
    do
       link_file $i
    done
else
    for i in _*
    do
        link_file $i
    done
fi

