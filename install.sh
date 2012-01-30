#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -f "${target}" ]; then
        mv $target bak/$target
    fi

        echo $source
        echo $target
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
        echo $i
        link_file $i
    done
fi

