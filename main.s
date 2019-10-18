#ifndef __ATtiny85__
#   define __ATtiny85__
#endif

; Without this I would have to use
; _SRT_IO_ADDR for every IO Register
#define __SFR_OFFSET 0

#include <avr/io.h>

; Registers
#define data R16
#define copy R17
#define i R21

; Pins
#define SER 0
#define SRCLK 1
#define RCLK 2

#define HIGH(PIN) sbi PORTB, PIN
#define LOW(PIN) cbi PORTB, PIN

.section .text
.global main
main:
                ldi R20, 0b00000111
                out DDRB, R20

                wdr
                ldi R20, ~_BV(WDRF)
                out MCUSR, R20
                ldi R20, _BV(WDIE) | _BV(WDCE) | _BV(WDP1)
                out WDTCR, R20

                sei

loop:
                ldi i, 8
                mov copy, data
inner:
                LOW(SRCLK)
                sbrc copy, 0
                HIGH(SER)
                sbrs copy, 0
                LOW(SER)
                HIGH(SRCLK)
                asr copy
                dec i
                brne inner

                LOW(RCLK)
                HIGH(RCLK)
                rjmp loop
                
.global WDT_vect
WDT_vect:
                inc data
                reti

.global __vector_default
__vector_default:
                reti
.end

; vim:autoindent ft=avr:ts=16
