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
.equ INTC_MIR_CLEAR1,     0xA8        @ INTC_MIR_CLEAR2     register offset
@.equ INTC_MIR_CLEAR2,     0xC8        @ INTC_MIR_CLEAR2     register offset
.equ INTC_MIR_CLEAR3,     0xE8        @ INTC_MIR_CLEAR3     register offset
.equ GPIOINT1A,           0x4         @ GPIOINT1A in MIR3   Mask
.equ UART4INT,			  0xD 		  @ UART4INT in MIR1	Mask

@ reg assignment definitions
intcBase .req R10

@***************************** start _init_interrupt ***************************
	STMFD SP!, {R0-R10, LR}
	
	LDR intcBase, =INTC_BASE
	
	@ INTC for button press
	MOV R1, #GPIOINT1A
	STR R1, [intcBase, #INTC_MIR_CLEAR3]
	
	@ INC for UART4A
	MOV R1, #UART4INT
	STR R1, [intcBase, #INTC_MIR_CLEAR1]
	
	@ Enable IRQ in CPSR	
	MRS R1, CPSR
	BIC R1, #0x80
	MSR CPSR_c, R1
	
	LDMFD SP!, {R0-R10, PC}
.end