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

@ GPIO definitions
.equ GPIO1_BASE,		  0x4804C000  @ GPIO1 				Base Address
.equ GPIO_IRQ_STAT_0,	  0x2C	  	  @ GPIO_IRQSTATUS_0 	register offset
.equ GPIO_31,			  0x80000000  @ GPIO_31 raised bit	Mask

@ register assignment definitions
intcBase  .req R10
gpio1Base .req R9

@******************************* start _int_director ***************************
	STMFD SP!, {R0-R12, LR}
	LDR intcBase, =INTC_BASE
UART4_IRQ_TST:
	

BTN_IRQ_TST:
	@ Check if INT occured from GPIO1
	LDR R0, [intcBase, #INTC_PENDING_IRQ3]
	TST R0, #GPIOINT1A
	@BEQ TIMER_IRQ_TST   @ place holder for future timer
	BEQ END_SVC
	
	@ Check if the button on GPIO_31 triggered the interrupt
	LDR gpio1Base, =GPIO1_BASE
	LDR R0, [gpio1Base, #GPIO_IRQ_STAT_0]
	TST R0, #GPIO_31
	BNE SVC_BUTTON @ If GPIO_31 has a pending interrupt, service the button
	
	

SVC_BUTTON:

CTS_TST:

THR_TST:

SCV_TALKER:

SEND_CHAR:



END_SVC:
	@ Disable NEWIRQA bit so processor can respond to IRQ
	MOV t2, #0x1
	STR t2, [intc_baseAddr, #INTC_CONTROL]	

	LDMFD SP!, {R0-R12, LR}
	SUBS PC, LR, #0x4
.end