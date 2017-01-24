@ Filename: project2_P3_toggleLED.s
@ Recieves a bit position, the desired output and the gpio base address
@ for desired gpio bank
@
@ If output is set low, sends a low signal to the desired pin
@ If output is set high, sends a high signal to the desired pin
@
@ Board: Beagle Bone Black
@ Written by: James Ross


@ void GPIO_toggleLED(word setMask, bool output, word gpioBaseAddr)
.text
.global _GPIO1_toggleLED

_GPIO1_toggleLED:
.equ GPIO_CLEAR_DATA_OUT, 0x190 @ GPIO_CLEARDATAOUT register adderess
.equ GPIO_SET_DATA_OUT,   0x194 @ GPIO_SETDATAOUT register address


setMask      .req R1   @ Passed from caller
output       .req R2   @ Passed from caller
gpioBaseAddr .req R3   @ passed from caller
clearDataOut .req R4   @ Sets to GPIO1_CLEARDATAOUT register
setDataOut   .req R5   @ Sets to GPIO1_SETDATAOUT register

    STMFD R13!, {R1-R5, LR} @ Push, start function

    CMP output, #0x00 @ Set high or low?
    BEQ SET_LOW

SET_HIGH:
    STR setMask, [gpioBaseAddr, #GPIO_SET_DATA_OUT]
    B END

SET_LOW:
    STR setMask, [gpioBaseAddr, #GPIO_CLEAR_DATA_OUT]

END:
    LDMFD R13!, {R1-R5, PC}     @ Pop, End function
.end
