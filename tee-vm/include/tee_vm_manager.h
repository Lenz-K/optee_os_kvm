#ifndef OPTEE_CLIENT_KVM_TEE_VM_MANAGER_H
#define OPTEE_CLIENT_KVM_TEE_VM_MANAGER_H

/**
 * Sets up a VM with one VCPU and loads the specified ELF file into the memory of the VM.
 * It then sets the program counter of the VM to the entry adress of the program.
 *
 * @return 0 on success, -1 if an error occurred.
 */
int start_vm(const char *elf_name);

/**
 * Lets the VM execute code until the hypervisor stops its execution and returns the control to this program.
 *
 * @return 0 on success, -1 if an error occurred.
 */
int run_vm(void);

/**
 * Deletes the VM and frees its resources.
 */
void close_vm(void);

#endif //OPTEE_CLIENT_KVM_TEE_VM_MANAGER_H
