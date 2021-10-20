#!/bin/sh

JOBS=3
echo Building with $JOBS jobs

echo Initializing Repositories:
# Use a custom manifest file
repo init -u https://github.com/Lenz-K/optee_os_kvm.git -b plat-kvm -m kvm.xml
repo sync -j $JOBS
cd build
# Use a custom Makefile
ln -s ../optee_os/kvm.mk Makefile

echo make toolchains:
make toolchains -j$JOBS

echo make:
make -j$JOBS

