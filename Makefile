# Compiler, Linker and Assembler
CC=gc
CXX=g++
ASM=nasm
LD=ld

# Compiler, Assembler and Linker flags go here
CCFLAGS=-Wall -ffreestanding  -I include
CXXFLAGS+=CCFLAGS
LDFLAGS=-T linker.ld --format pe-x86-64 -nostdlib --default-image-base-low
ASMFLAGS=-f bin

# Object files go here
OBJS=obj/kernel.o

# Binaries go here
BIN=bin/kernel.bin
ASMBIN=bin/boot.bin

# Virtual Machines go here
VM=qemu-system-x86_64

# PHONY targets
.PHONY: bootstrap iso clean run

all: $(OBJS) $(BIN) $(ASMBIN)

# Compile C source files
obj/%.o: src/%.c
	$(CC) -c $(CCFLAGS) -o $@ $<

# Compile C source files
obj/%.o: src/%.cpp
	$(CXX) -c $(CCFLAGS) -o $@ $<

$(ASMBIN): asm/boot.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BIN): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $<

run: all
	$(VM) bin/boot.bin

clean:
	rm -rf bin/*.bin obj/*
