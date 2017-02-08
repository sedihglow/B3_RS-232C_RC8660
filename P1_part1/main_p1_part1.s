@ This program will use a RS-232C driver to make speach come out of an RC
@ systems 8660 coice synthesizer.
@
@ File name: main_p1_part1.s
@ Board: Beagle Bone Black
@ Written by: James Ross

.text
.global MESSAGE
.global CHAR_PTR
.global _start
_start:
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
	
INIT_INTERRUPT:
	BL _init_interrupt

INIT_GPIO:
	BL _init_gpio
	
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
.align 4
	MESSAGE:
		.byte 0x01   @ Start voice setting
		.ascii "7O"  @ Voice of Robo Robert
		.byte 0x01   @ Start of volume setting
		.ascii "0V"	 @ Set volume 0 of 9 (lowest setting, still loud)
		.byte 0x1
		.ascii "4S"
		.ascii "I don't want to count the letters"
		.byte 0x0D
.align 4
	CHAR_PTR:
		.word MESSAGE
.end
@@@@@@@@@@ EOF @@@@@@@@@@