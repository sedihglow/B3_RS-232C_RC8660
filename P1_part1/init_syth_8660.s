@ filename: init_syth_8660.s
@
@ Initializes the features and rates of the RC8660 through UART4
@
@ Written by: James Ross

.text
.global _init_syth_8660
_init_syth_8660:
@ UART definitions
.equ UART4_BASE,    0x481A8000 @ UART4          	      Base Address
.equ UART_TXHR,	    0x0	  	   @ THR Transmit Holding     register offset
.equ CR_LOCKBAUD,   0x0D	   @ Character to send to 8660 to lock Baud rate

@.equ NUM, 0x00340000 @ for testing

@ register assignment definitions
uart4Base .req R10

@********************* Start _init_syth_8660 ***********************************

	STMFD SP!, {R0-R10, LR}
	
	LDR uart4Base, =UART4_BASE
	
	@ Lock the baud rate. SEE NOTE IN INT_UART4 on strange behavior
	MOV R4, #CR_LOCKBAUD
	STR R4, [uart4Base, #UART_TXHR]
	
	@ Any command 75ms after baud rate is locked will be ignored. Will not have
	@ to worry about it since it puts CTS high during that time period


@*********** THIS TEST CODE WORKS BUT DOES USE LITERAL POOL AND POINT. QQ ******
@   	movs  r0, #NUM    
@LOOP: subs  r0, r0, #1  
@   	  bne   LOOP
	 
@	 MOV R5, #0x61
@	 STR R5, [uart4Base, #UART_TXHR]
   	  
@   	movs  r0, #NUM    
@LOOP2: subs  r0, r0, #1  
@   	  bne   LOOP2
   	  
@	MOV R4, #CR_LOCKBAUD
@	STR R4, [uart4Base, #UART_TXHR]
	
	
@  	movs  r0, #NUM    
@LOOP3: subs  r0, r0, #1  
@   	  bne   LOOP3
	
@	 MOV R5, #0x61
@	 STR R5, [uart4Base, #UART_TXHR]
	 
@   	movs  r0, #NUM    
@LOOP4: subs  r0, r0, #1  
@   	  bne   LOOP4
	
@	MOV R4, #CR_LOCKBAUD
@	STR R4, [uart4Base, #UART_TXHR]
	
@*************** END TEST CODE 1 **********************************************	
	
@   	movs  r0, #NUM    
@LOOP4: subs  r0, r0, #1  
@   	  bne   LOOP4
   	  
@   	  LDR R0, =CHAR_PTR
@   	  LDR R1, [R0]
@   	  LDRB R4, [R1], #1 
@   	  STRB R4, [uart4Base, #UART_TXHR] 
@   	movs  r0, #NUM    
@LOOP2: subs  r0, r0, #1  
@   	  bne   LOOP2
	
@   	  LDR R0, =CHAR_PTR
@   	  LDR R1, [R0]
@   	  LDRB R4, [R1], #1
@   	  STR R1, [R0]
@   	  STRB R4, [uart4Base, #UART_TXHR]

@ ***************** END FAIL TEST CODE 2 WITH POINTER, WHYYYY *****************
   	  
   
	LDMFD SP!, {R0-R10, PC}
.end
@*************** EOF **************