#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    exit -1
fi
cp semantic-ctxt.el $1.el
sed -i "s/semantic-ctxt/$1/g" $1.el

