#!/bin/bash

cd $WORKSPACE
$(which packer) build ./ubuntu-current-virtualbox.json

if [ -a $WORKSPACE/packer-ubuntu-current.box ]; then
rm $WORKSPACE/packer-ubuntu-current.box
fi
