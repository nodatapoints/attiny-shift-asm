.PHONY: clean check upload

PROGRAMMER=usbasp
CHIP=attiny85

AVRDUDE=avrdude -c ${PROGRAMMER} -p ${CHIP}
GCC_FLAGS=-xassembler-with-cpp -g -O3 -mmcu=${CHIP} 
GCC=avr-gcc
HFUSE=0xDF

upload: main.hex
		${AVRDUDE} -U flash:w:$< -U hfuse:w:${HFUSE}:m

main.elf: main.s
		${GCC} ${GCC_FLAGS} -o $@ $<

main.hex: main.elf
		avr-objcopy -O ihex $< $@

check:
		${AVRDUDE}

clean:
		rm -rvf *.hex *.elf

