@ filename: init_gpio.s
@
@ initializes the required GPIO pins for project1
@
@ Written by: James Ross

.text
.global _init_gpio
_init_gpio:
@ CLK definitions
.equ CLK_EN, 		   0x00000002   @ Sets IDLEST functional, Module mode EN
.equ GPIO1_CLK_CTRL,   0x44E000AC   @ CM_PER_GPIO1_CLKCTRL  register address

@ GPIO definitions
.equ GPIO1_BASE,          0x4804C000  @ GPIO1               Base Address
.equ GPIO_OE,             0x134       @ GPIO_OE             register offset
.equ GPIO_CLEAR_DATAOUT,  0x190       @ GPIO_CLEARDATAOUT   register offset
.equ GPIO_SET_DATAOUT,    0x194       @ GPIO_SETDATAOUT     register offset
.equ GPIO_FALLING_DETECT, 0x14C       @ GPIO_FALLINGDETECT  register offset
.equ GPIO_IRQSTAT0,       0x2C        @ GPIO_IRQSTATUS_0    register offset
.equ GPIO_IRQSTAT_SET0,   0x34        @ GPIO_IRQSTAT_SET_0  register offset
.equ GPIO1_31_BIT,		  0x800000000 @ GPIO1_31 bit

@ Interupt definitions
.equ INTC_BASE,           0x48200000  @ INCPS               Base Address
.equ INTC_CONTROL,        0x48        @ INTC_CONTROL        register offset
.equ INTC_CONFIG,         0x10        @ INTC_SYSCONFIG      register offset
.equ INTC_MIR_CLEAR2,     0xC8        @ INTC_MIR_CLEAR2     register offset
.equ INTC_MIR_CLEAR3,     0xE8        @ INTC_MIR_CLEAR3     register offset
.equ INTC_MIR_SET3,       0xEC        @ INTC_MIR_SET3       register offset
.equ INTC_PENDING_IRQ3,   0xF8        @ INTC_PENDING_IRQ3   register offset
.equ GPIOINT1A,           0x4         @ GPIOINT1A in MIR3   Mask

@ LED definitions
.equ SET_LED1_OUTPUT, 0xFFBFFFFF      @ Mask to set GPIO1_22 as output
.equ SET_LED1,    	  0x00400000      @ Mask to set LED1, GPIO1_22

@ reg assignment definitions
gpio1Base .req R9					  @ R9 reserved for gpio1 base address

@*********************** start _init_gpio **************************************
	STMFD SP!, {R1-R10, LR}
	
	MOV R4, #CLK_EN	    	  @ R4 Holds mask for enableing clocks
	LDR R5, =GPIO1_CLK_CTRL
	STR R4, [R5]			  @ Store CLK_EN to enable GPIO1 clk
	
	@ Set GPIO1_22 as output
	LDR gpio1Base, =GPIO1_BASE
	MOV R8, #SET_LED1			@ GPIO1_22
	STR R8, [gpio1Base, #GPIO_CLEAR_DATAOUT]
	
	@ Enable GPIO1_22
	ADD R7, gpio1Base, #GPIO_OE @ Set R7 as GPIO output enable
	MOV R8, #SET_LED1_OUTPUT	@ GPIO1_ 22, R8 set to LED1 output enable value
	LDR R6, [R7]			    @ Load
	ORR R6, R6, R8 			    @ Modify
	STR R6, [R7]				@ Store to set LED1 as output
	
@********************** set interrupts *****************************************
	@ Set interupt to trigger from high to low on GPIO1_31	
	ADD R4, gpio1Base, #GPIO_FALLING_DETECT
	MOV R5, #GPIO1_31_BIT
	LDR R6, [R4]
	ORR R6, R6, R5			@ Set bit for GPIO1_31 falling edge detect
	STR R6, [R4]			@ Store back in reg
	
	@ Enable interrupt field for GPIO_31
	STR R5, [gpio1Base, #GPIO_IRQSTAT_SET0]
	
	LDMFD SP!, {R1-R10, PC}
.end