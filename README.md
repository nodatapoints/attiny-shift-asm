## controlling a shift register using assembly

Back to the roots: Controlling a shift register from an ATtiny85 microcontroller only using AVR assembly.

I used the `avr-gcc` compiler. Much to my surprise I could hardly find any information on assembly programming using `avr-gcc`, so I figured I'd share my results. The extensive header definitions of `avr-libc` as well as the full power of `gcc` macros provide a powerful environment for programming AVR-ASM.

Note the `__SFR_OFFSET` set to `0` -- apparently the offset isn't needed at all using assembly, but very important for C.

### Building and Programming
To compile and upload use

```
make
```
The Makefile is currently configured to upload the hex file using `avrdude` with the `usbasp`-programmer. If you use another programmer change the `PROGRAMMER` variable in the Makefile or upload `main.hex` manually.
