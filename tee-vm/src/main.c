#include "tee_vm_manager.h"

int main(int argc, char **argv) {
    int ret = start_vm("./bin/tee.elf");

    while (ret == 0)
        ret = run_vm();

    return 0;
}

