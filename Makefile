GPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -I.
ASPARAMS = -32
LDPARAMS = -melf_i386

objects = loader.o gdt.o interrupts.o port.o keyboard.o interruptstubs.o kernel.o

%.o: %.cpp
	g++ $(GPPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

clean:
	rm -rf *.o
	rm -rf mykernel.bin