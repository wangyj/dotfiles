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
        target="/${file}"
        if [ -e "${target}" ]; then
            mv $target $target.bak
        else
            mkdir -p $(dirname $target)
        fi
        ln -sf ${source} ${target}
    fi
}

link_dir_file etc

