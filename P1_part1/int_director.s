@ filename: int_director.s
@
@ Interrupt handler for UART4, GPIO1_31 button, eventually a timer
@
@ Written by: James Ross

.text
.global _int_director
_int_director:
@ Interupt definitions
.equ INTC_BASE,           0x48200000  @ INCPS               Base Address
.equ INTC_CONTROL,        0x48        @ INTC_CONTROL        register offset
.equ INTC_CONFIG,         0x10        @ INTC_SYSCONFIG      register offset
.equ INTC_MIR_CLEAR2,     0xC8        @ INTC_MIR_CLEAR2     register offset
.equ INTC_MIR_CLEAR3,     0xE8        @ INTC_MIR_CLEAR3     register offset
.equ INTC_MIR_SET3,       0xEC        @ INTC_MIR_SET3       register offset
.equ INTC_PENDING_IRQ3,   0xF8        @ INTC_PENDING_IRQ3   register offset
.equ GPIOINT1A,           0x4         @ GPIOINT1A in MIR3   Mask

@******************************* start _int_director ***************************
	STMFD SP!, {R0-R12, LR}








END_SVC:
	@ Disable NEWIRQA bit so processor can respond to IRQ
	MOV t2, #0x1
	STR t2, [intc_baseAddr, #INTC_CONTROL]	

	LDMFD SP!, {R0-R12, LR}
	SUBS PC, LR, #0x4
.end