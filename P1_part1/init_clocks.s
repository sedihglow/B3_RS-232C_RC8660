@ filename: init_clocks.s
@
@ Initializes all the clocks used for gpio, uart, timer.
@
@ Written by: James Ross


.text
.global _init_clocks
_init_clocks:
.equ CM_PER_BASE,      0x44E00000 @ CM_PER base register
.equ GPIO1_CLK_CTRL,   0xAC   	  @ CM_PER_GPIO1_CLKCTRL  register offset
@.equ TIMER3_CLK_CTRL,  0x84   	  @ CM_PER_TIMER3_CLKCTRL register offset
@.equ TIMER3_CLKSEL,    0x50C     @ CLKSEL_TIMER3_CLK     register offset
.equ UART4_CLK_CTRL,   0x78       @ CM_PER_UART_CLKCTRL   register offset
.equ CLK_EN, 		   0x00000002 @ Sets IDLEST functional, Module mode EN

cmPerBase 	.req R10
enableClock .req R9

@***************************** Start _int_clocks *******************************
	STMFD SP!, {R0-R10, LR}
	
	LDR cmPerBase, =CM_PER_BASE
	MOV enableClock, #CLK_EN
	
	@ Enable GPIO1 clock
	ADD R3, cmPerBase, #GPIO1_CLK_CTRL	
	STR enableClock, [R3]		  @ Store CLK_EN to enable GPIO1 clk
	
	@ Enable UART clock
	STR enableClock, [cmPerBase, #UART4_CLK_CTRL]
	
	LDMFD SP!, {R0-R10,PC}
.end
@*************** EOF ***************