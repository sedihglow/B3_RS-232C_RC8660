@ This program will use a RS-232C driver to make speach come out of an RC
@ systems 8660 coice synthesizer.
@
@ File name: main_p1_part2.s
@ Board: Beagle Bone Black
@ Written by: James Ross

.text
.global _start
_start:
@********************* Definitions *********************************************
.equ COUNT, 0x0A 	@ Count for COUNT_VAL, records number countdown is on
.equ MSG_LEN, 0x2A  @ total message length

@********************** START _start *******************************************

INIT_STACK:
	LDR SP, =SVC_STACK
	ADD SP, SP, #0x1000 @ point to top of stack
	CPS #0x12			@ Switch to IRQ mode
	
	LDR SP, =IRQ_STACK
	ADD SP, SP, #0x1000
	CPS #0x13			@ Switch back to SVC mode
	
INIT_PIN_MAP:
	BL _init_pinMap
	
INIT_CLOCKS:
	BL _init_clocks

INIT_UART4:
	BL _init_uart4
	
INIT_8660:
	BL _init_syth_8660

INIT_TIMER3:
	BL _init_timer3

INIT_GPIO:
	BL _init_gpio
	
INIT_INTERRUPT:
	BL _init_interrupt
	
WAIT_LOOP:
	B WAIT_LOOP

.data
.align 4
	SVC_STACK:
		.rept 1024
			.word 0x0000
		.endr
	IRQ_STACK:
		.rept 1024
			.word 0x0000
		.endr
.end
@@@@@@@@@@ EOF @@@@@@@@@@