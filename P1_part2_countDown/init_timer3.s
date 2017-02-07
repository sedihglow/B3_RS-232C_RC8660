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
.equ TIMER_IRQEN_SET,     0x2C        @ IRQENABLE_SET       register offset
.equ TIMER_TCLR,          0x38        @ TCLR                register offset
.equ TIMER_TCRR,          0x3C        @ TCRR                register offset
.equ TIMER_TLDR,          0x40        @ TLDR                register offset
.equ TIMER_COUNTER_VAL,   0xFFFF80FF  @ Loaded into TLDR and TCRR, 1.00793s

