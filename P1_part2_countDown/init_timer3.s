@ filename: init_timer3.s
@
@ This function initializes timer3 for 1second intervals
@
@ written by: James Ross

.text
.global _init_timer3
_init_timer3:
@ Timer defintions
.equ TIMER3_BASE,         0x48042000  @ DMTIMER3            Base Address
.equ TIMER_TIOCP_CFG,     0x10        @ TIOCP_CFG           register offset
.equ TIMER_TCLR,          0x38        @ TCLR                register offset
.equ TIMER_TCRR,          0x3C        @ TCRR                register offset
.equ TIMER_TLDR,          0x40        @ TLDR                register offset
.equ TIMER_COUNTER_VAL,   0xFFFF80FF  @ Loaded into TLDR and TCRR, 1.00793s

.equ SW_RESET,			  0x01		  @ soft reset in CGF	Val

@ register assignment definitions
timer3Base .req R10

@********************* START _init_timer3 **************************************
	STMFD SP!, {R2, R10, LR}
	
	LDR timer3Base, =TIMER3_BASE
	
	@ Set count value in TLDR and TCRR
	LDR R2, =TIMER_COUNTER_VAL
	STR R2, [timer3Base, #TIMER_TLDR]
	STR R2, [timer3Base, #TIMER_TCRR]
	
	@ Initialize timer3 registers. set count and overflow INT generation	
	MOV R2, #SW_RESET	 @ value for software reset in TIOCP_CFG
	STR R2, [timer3Base, #TIMER_TIOCP_CFG]
	
	LDMFD SP!, {R2, R10, PC}
.end
@************* EOF ***************