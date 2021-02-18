#!/bin/sh

/opt/gnuarm/bin/arm-none-eabi-gcc -c iboot_p1.s
/opt/gnuarm/bin/arm-none-eabi-objdump -D iboot_p1.o
/opt/gnuarm/bin/arm-none-eabi-objcopy -O binary iboot_p1.o iboot_p1.bin
rm iboot_p1.o

/opt/gnuarm/bin/arm-none-eabi-gcc -c payload.s
/opt/gnuarm/bin/arm-none-eabi-objdump -D payload.o
/opt/gnuarm/bin/arm-none-eabi-objcopy -O binary payload.o payload.bin
rm payload.o
