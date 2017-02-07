.text
.global _start
_start:

	LDR R13, =SVC_STACK
	NOP
	
.data
	SVC_STACK:
		.rept 1024
			.word 0x000
		.endr
.end