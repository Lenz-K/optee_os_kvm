#ifndef OPTEE_CLIENT_KVM_TEE_VM_MANAGER_H
#define OPTEE_CLIENT_KVM_TEE_VM_MANAGER_H

/**
 *
 */
int start_vm(const char *elf_name);

/**
 *
 */
int run_vm(void);

/**
 *
 */
void close_vm(void);

#endif //OPTEE_CLIENT_KVM_TEE_VM_MANAGER_H
