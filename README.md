# OP-TEE Trusted OS
This git contains source code for the secure side implementation of OP-TEE
project.

All official OP-TEE documentation has moved to http://optee.readthedocs.io.

// OP-TEE core maintainers

# OP-TEE platform KVM
This fork of the OP-TEE Trusted OS aims to configure an additional platform ([plat-kvm](https://github.com/Lenz-K/optee_os_kvm/tree/plat-kvm/core/arch/arm/plat-kvm)) that is supposed to run on KVM/ARM.

## Prerequisites

To be able to build OP-TEE install the dependencies listed [here](https://optee.readthedocs.io/en/latest/building/prerequisites.html).

Also install the AOSP Repo tool. Instructions can be found [here](https://source.android.com/setup/develop#installing-repo).

## Building

To download the necessary sources and build OP-TEE, it is recommended to create a script with the contents of [build_kvm.sh](https://github.com/Lenz-K/optee_os_kvm/blob/plat-kvm/build_kvm.sh) and place it in a directory of your choice and execute it. The script will download several repositories includng this one. It will then start the make process.

