#!/bin/bash
nasm -f bin boot_sect.asm -o boot_sect.bin
qemu-system-x86_64 boot_sect.bin
