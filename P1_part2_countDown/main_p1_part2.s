@ This program will use a RS-232C driver to make speach come out of an RC
@ systems 8660 coice synthesizer.
@
@ File name: main_p1_part2.s
@ Board: Beagle Bone Black
@ Written by: James Ross

.text
.global COUNT_VAL
.global BLASTOFF_LEN
.global BLASTOFF
.global CHAR_PTR
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
/*	CHAR_PTR:
		.word BLASTOFF
	COUNT_VAL:
		.word COUNT
	BLASTOFF_LEN:
		.word MSG_LEN
.align 4
	BLASTOFF:
		.byte 0x01
		.ascii "7O"  @ Voice of Robo Robert
		.byte 0x01
		.ascii "0V"	 @ Set volume 0 of 9 (lowest setting, still loud)
		.byte 0x01
		.ascii "4S"	 @ Speech rate reduced by 1 from default 5
		.ascii "10"
		.byte 0x0D
		.ascii "9"
		.byte 0x0D
		.ascii "8"
		.byte 0x0D
		.ascii "7"
		.byte 0x0D
		.ascii "6"
		.byte 0x0D
		.ascii "5"
		.byte 0x0D
		.ascii "4"
		.byte 0x0D
		.ascii "3"
		.byte 0x0D
		.ascii "2"
		.byte 0x0D
		.ascii "1"
		.byte 0x0D
		.ascii "0"
		.byte 0x0D
		.ascii "Blast off"
		.byte  0x0D
*/
.end
@@@@@@@@@@ EOF @@@@@@@@@@