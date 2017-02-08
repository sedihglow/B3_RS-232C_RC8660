@ filename: init_interrupt.s
@
@ initializes the registers from INT controller
@
@ written by: James Ross

.text
.global _init_interrupt
_init_interrupt:
@ Interupt definitions
.equ INTC_BASE,           0x48200000  @ INCPS               Base Address
.equ INTC_MIR_CLEAR1,     0xA8        @ INTC_MIR_CLEAR1     register offset
.equ INTC_MIR_CLEAR2,	  0xC8		  @ INTC_MIR_CLEAR2		register offset
.equ INTC_MIR_CLEAR3,     0xE8        @ INTC_MIR_CLEAR3     register offset
.equ GPIOINT1A,           0x4         @ GPIOINT1A in MIR3   Val
.equ UART4INT,			  0x2000 	  @ UART4INT in MIR1	Val
.equ TINT3,               0x20        @ TINT3 in MIR2       Val

@ reg assignment definitions
intcBase .req R10

@***************************** start _init_interrupt ***************************
	STMFD SP!, {R1, R10, LR}
	
	LDR intcBase, =INTC_BASE
	
	@ INTC for button press
	MOV R1, #GPIOINT1A
	STR R1, [intcBase, #INTC_MIR_CLEAR3]
	
	@ INTC for UART4A
	MOV R1, #UART4INT
	STR R1, [intcBase, #INTC_MIR_CLEAR1]
	
	@ INTC for timer3
	MOV R1, #TINT3
	STR R1, [intcBase, #INTC_MIR_CLEAR2]
	
	@ Enable IRQ in CPSR	
	MRS R1, CPSR
	BIC R1, #0x80
	MSR CPSR_c, R1
	
	LDMFD SP!, {R1, R10, PC}
.end
@************** EOF *************