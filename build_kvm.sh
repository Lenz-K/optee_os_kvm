#!/bin/sh

JOBS=3

repo init -u https://github.com/Lenz-K/optee_os_kvm.git -b plat-kvm -m kvm.xml
repo sync -j $JOBS
cd build
ln -s ../optee_os/kvm.mk Makefile
make toolchains -j$JOBS
make -j$JOBS

