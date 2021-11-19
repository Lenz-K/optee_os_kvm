all: tee_vm

tee_vm:
	$(CC) -o tee_vm src/main.c src/tee_vm_manager.c src/elf_loader.c -I include

clean:
	rm -f tee_vm
