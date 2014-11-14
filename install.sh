#!/usr/bin/env bash

## ruby:
##    we need pry/pry-doc gem install for robe-mode
##    we need rcodetools/rsense gem install for fastri/rsense/rcodetools
##    rvm docs generate to generate all docs for yari

usage()
{
    echo >&2 "$0 [-d directory [directory ...]] file.el [file.el ...]

    where is added to the load-path during compilation."
    [ $# -eq 0 ] || echo "$@" >&2
    exit 1
}

if [ $# -eq 0 ]
then
    rm -rf *.elc conf/*.elc
    touch myinfo.el
    echo "install elpa package"
    emacs -q --batch -l batch_install_elpa.el
    echo "installing elpa package....done"
    echo "installing el-get package...."
    wget --no-check-certificate "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
    emacs --script el-get-install.el
    rm el-get-install.el
    echo "installing el-get package....done"
    echo "installing other packages...."
    emacs -q --batch -L el-get/el-get/ -l setup/el-get-all.el
    echo "installing other packages....done"
fi

for directory in ~/.emacs.d/*; do
    if [ -d $directory ]; then
        LOAD_PATH="$LOAD_PATH -L $directory"
    fi
done
emacs -batch -no-init-file $LOAD_PATH -f batch-byte-compile *.el conf/*.el misc/*.el


# if [ $# -eq 1 ]
# then
#     setup_file="setup/el-get-$1.el"
#     if [ -f $setup_file ]
#     then
#       emacs -batch -l el-get/el-get/el-get.el -l elpa/package.el -l $setup_file
#     else
#       setup_file=`grep -r $1 setup | line | cut -d ':' -f 1`
#       if [ -f $setup_file ]
#       then
#       emacs -batch -l el-get/el-get/el-get.el -l elpa/package.el -l $setup_file
#       fi
#     fi

# fi


# if [ $# -eq 0 ]
# then
#     rm -rf *.elc conf/*.elc
#     touch myinfo.el
#     echo "installing el-get package...."
#     wget --no-check-certificate https://github.com/dimitri/el-get/raw/master/el-get-install.el
#     emacs --script el-get-install.el
#     rm el-get-install.el
#     echo "installing el-get package....done"
#     echo "installing other packages...."
#     for setup_file in setup/*.el
#     do
#       emacs -batch -l el-get/el-get/el-get.el -l elpa/package.el -l $setup_file
#     done
#     echo "installing other packages....done"
# fi
