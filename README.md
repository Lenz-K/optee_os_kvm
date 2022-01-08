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
To download the necessary sources and build OP-TEE, it is recommended to create a script with the contents of [build_for_kvm.sh](https://github.com/Lenz-K/optee_os_kvm/blob/plat-kvm/build_for_kvm.sh) and place it in a directory of your choice and execute it. The script will download several repositories including this one (They are defined in [kvm.xml](https://github.com/Lenz-K/optee_os_kvm/blob/plat-kvm/kvm.xml)). It will then start the make process using the makefile [kvm.mk](https://github.com/Lenz-K/optee_os_kvm/blob/plat-kvm/kvm.mk). The script contains a variable `JOBS` that defines the amount of jobs in several steps of the build process.

The ELF file containing OP-TEE OS and the trusted applications can be faund at `./optee_os/out/arm/core/tee.elf`

# TEE VM Manager
The folder tee-vm contains the source code of a program that sets up a VM and runs the ELF file `tee-vm/bin/tee.elf` in it.
- To build the program run `make` in the folder `tee-vm`.
- To then execute the program use `./tee_vm`.

For cross-compilation set the variable `CC` to the location of the compiler for the target architecture, before running `make`.

_Note: When the executable is then copied to the target, the ELF file needs to be copied there as well (into the subfolder `./bin` relative to the executable)._
