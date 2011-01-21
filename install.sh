#!/usr/bin/env bash

usage()
{
    echo >&2 "$0 [-d directory [directory ...]] file.el [file.el ...]

    where is added to the load-path during compilation."
    [ $# -eq 0 ] || echo "$@" >&2 
    exit 1
}

rm -rf *.elc conf/*.elc
touch myinfo.el
wget --no-check-certificate https://github.com/dimitri/el-get/raw/master/el-get-install.el
emacs --script el-get-install.el
rm el-get-install.el
emacs -L el-get/el-get --script setup/el-get-misc.el
# for directory in ~/.emacs.d/*; do
#     if [ -d $directory ]; then
# 	LOAD_PATH="$LOAD_PATH -L $directory"
#     fi
# done
# echo $LOAD_PATH
# emacs -batch -no-init-file $LOAD_PATH -f batch-byte-compile *.el conf/*.el misc/*.el
