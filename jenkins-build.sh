#!/bin/bash -ex

cd $WORKSPACE

# Pre cleanup
vboxmanage controlvm packer-ubuntu-current poweroff || true
vboxmanage unregistervm packer-ubuntu-current --delete || true
rm -rf $WORKSPACE/packer/output-ubuntu-current || true
rm -rf /var/lib/jenkins/VirtualBox\ VMs/packer-ubuntu-current || true

$(which packer) build ./ubuntu-current-virtualbox.json || exit 1;


export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

$(which gof3r) put -c 1 -p $WORKSPACE/packer-ubuntu-current.box -b 1213212412134 -k vagrant/packer-ubuntu-current.box || exit 1;

# Post cleanup
rm $WORKSPACE/packer-ubuntu-current.box || true

