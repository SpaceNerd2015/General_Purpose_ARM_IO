@ File: BlinkingLED3.s

@ Author: R. Kevin Preston (with additions made by Hayley Johnsey for Lab 4)

@ Purpose: Provide enough assembly to allow students to complete an assignment. 

@          This code turns the four LEDs on then off several times. The LEDs are

@          connected to the GPIO on the Raspberry Pi. The details on the 

@          hardware and GPIO interface are in another document. 

@

@ Use these commands to assemble, link and run the program

@

@  as -o BlinkingLED3.o BlinkingLED3.s

@  gcc -o BlinkingLED3 BlinkingLED3.o -lwiringPi

@  sudo ./BlinkingLED3

@ 

@ gdb --args ./BlinkingLED3 !! Cannot use the debugger with sudo. 

@

@ Define the constants for this code. 


OUTPUT = 1 @ Used to set the selected GPIO pins to output only. 



.text

.balign 4

.global main


main:


@ Use the C library to print the hello strings.
 
    LDR  r0, =string1   @ Put address of string in r0

     BL   printf         @ Make the call to printf


     LDR  r0, =string1a
 
    BL   printf         @ Make the call to printf



@ check the setup of the GPIO to make sure it is working right. 

@ To use the wiringPiSetup function just call it. On return:

@    r0 - contains the pass/fail code
 

       bl      wiringPiSetup

        mov     r1,#-1

        cmp     r0, r1

        bne     init  @ Everything is OK so continue with code.

        ldr     r0, =ErrMsg

        bl      printf

        b       errorout  @ There is a problem with the GPIO exit code.

@
@ Set four of the GPIO pins to output
@


@ set the pin2 mode to output

init:


        ldr     r0, =pin2

        ldr     r0, [r0]

        mov     r1, #OUTPUT

        bl      pinMode


@ set the pin3 mode to output


        ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #OUTPUT

        bl      pinMode


@ set the pin4 mode to output


        ldr     r0, =pin4
        ldr     r0, [r0]

        mov     r1, #OUTPUT

        bl      pinMode


@ set the pin5 mode to output


        ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #OUTPUT

        bl      pinMode
 

@
@ The pins are now set-up for output. 
@

@ To use the digitalWrite function:

@    r0 - must contain the pin number for the GPIO per the header file info

@    r1 - set to 1 to turn the output on or to 0 to turn the output off.

@

@ Turn all four LEDs on. 

@

@ Write a logic one to turn pin2 to on.


        ldr     r0, =pin2

        ldr     r0, [r0]
        mov     r1, #1

        bl      digitalWrite


@ Write a logic one to turn pin3 to on.


        ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite


@ Write a logic one to turn pin4 to on.


        ldr     r0, =pin4

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite


@ Write a logic one to turn pin5 to on.


        ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite


@ Run the delay otherwise it blinks so fast you never see it!

@ To use the delay function:

@    r0 - must contains the number of miliseconds to delay.
 

       ldr     r0, =delayMs

        ldr     r0, [r0]

        bl      delay

@

@ Turn all four LEDs off

@

@ Write a logic 0 to turn pin2 off.
 
       ldr     r0, =pin2

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite


@ Write a logic 0 to turn pin3 off.
 
       ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite
@ Write a logic 0 to turn pin4 off.
 
       ldr     r0, =pin4

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite


@ Write a logic 0 to turn pin5 off.
 
       ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite


@ Run the delay otherwise it blinks so fast you never see it!

        ldr     r0, =delayMs

        ldr     r0, [r0]

        bl      delay

@print another string
	ldr	r0, =task2string
	bl	printf


	mov 	r8, #2		@initialize hexcount counter

hexloop:
	mov	r4, #15		@initialize countdown variable
		
hexcount:
@binary count will use a loop that will toggle pin2 every time, pin3 every other time,
@ pin4, every 4th time, and pin5 every 8th time to produce the hex numbers from 0 to F

	@start some cmp statements
	cmp	r4, #15		@pin5=0, pin4=0, pin3=0, pin2=0
	beq	pin2off

	cmp	r4, #14		@pin5=0, pin4=0, pin3=0, pin2=1
	beq	pin2on

	cmp	r4, #13		@pin5=0, pin4=0, pin3=1, pin2=0
	beq	pin2off

	cmp	r4, #12		@pin5=0, pin4=0, pin3=1, pin2=1
	beq 	pin2on

	cmp	r4, #11		@pin5=0, pin4=1, pin3=0, pin2=0
	beq	pin2off

	cmp	r4, #10		@pin5=0, pin4=1, pin3=0, pin2=1
	beq	pin2on

	cmp	r4, #9		@pin5=0, pin4=1, pin3=1, pin2=0
	beq 	pin2off

	cmp	r4, #8		@pin5=0, pin4=1, pin3=1, pin2=1
	beq	pin2on

	cmp	r4, #7		@pin5=1, pin4=0, pin3=0, pin2=0
	beq	pin2off

	cmp 	r4, #6		@pin5=1, pin4=0, pin3=0, pin2=1
	beq	pin2on

	cmp	r4, #5		@pin5=1, pin4=0, pin3=1, pin2=0
	beq	pin2off

	cmp	r4, #4		@pin5=1, pin4=0, pin3=1, pin2=1
	beq	pin2on

	cmp	r4, #3		@pin5=1, pin4=1, pin3=0, pin2=0
	beq	pin2off

	cmp	r4, #2		@pin5=1, pin4=1, pin3=0, pin2=1
	beq 	pin2on

	cmp	r4, #1		@pin5=1, pin4=1, pin3=1, pin2=0
	beq	pin2off

	cmp	r4, #0		@pin5=1, pin4=1, pin3=1, pin2=1
	beq	pin2on

	blt	hexrounddone	@if r4 (counter) is less than 0, jump to hexrounddone
	
pin2on:
	@ Write a logic one to turn pin2 to on.


        ldr     r0, =pin2

        ldr     r0, [r0]
        mov     r1, #1

        bl      digitalWrite

	@cmp statements
	cmp r4, #14	@pin5=0, pin4=0, pin3=0, pin2=1
	beq pin3off

	cmp r4, #12	@pin5=0, pin4=0, pin3=1, pin2=1
	beq pin3on

	cmp r4, #10	@pin5=0, pin4=1, pin3=0, pin2=1
	beq pin3off

	cmp r4, #8	@pin5=0, pin4=1, pin3=1, pin2=1
	beq pin3on
	
	cmp r4, #6	@pin5=1, pin4=0, pin3=0, pin2=1
	beq pin3off

	cmp r4, #4	@pin5=1, pin4=0, pin3=1, pin2=1
	beq pin3on

	cmp r4, #2	@pin5=1, pin4=1, pin3=0, pin2=1
	beq pin3off

	cmp r4, #0	@pin5=1, pin4=1, pin3=1, pin2=1
	beq pin3on

pin2off:
	@ Write a logic 0 to turn pin2 off.
 
       ldr     r0, =pin2

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite

	@cmp statements
	cmp r4, #15	@pin5=0, pin4=0, pin3=0, pin2=0
	beq pin3off

	cmp r4, #13	@pin5=0, pin4=0, pin3=1, pin2=0
	beq pin3on

	cmp r4, #11	@pin5=0, pin4=1, pin3=0, pin2=0
	beq pin3off

	cmp r4, #9	@pin5=0, pin4=1, pin3=1, pin2=0
	beq pin3on

	cmp r4, #7	@pin5=1, pin4=0, pin3=0, pin2=0
	beq pin3off

	cmp r4, #5	@pin5=1, pin4=0, pin3=1, pin2=0
	beq pin3on

	cmp r4, #3	@pin5=1, pin4=1, pin3=0, pin2=0
	beq pin3off

	cmp r4, #1	@pin5=1, pin4=1, pin3=1, pin2=0
	beq pin3on

pin3on:
	@ Write a logic one to turn pin3 to on.


        ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite

	@cmp statements
	cmp r4, #13	@pin5=0, pin4=0, pin3=1, pin2=0
	beq pin4off

	cmp r4, #12	@pin5=0, pin4=0, pin3=1, pin2=1
	beq pin4off

	cmp r4, #9	@pin5=0, pin4=1, pin3=1, pin2=0
	beq pin4on

	cmp r4, #8	@pin5=0, pin4=1, pin3=1, pin2=1
	beq pin4on

	cmp r4, #5	@pin5=1, pin4=0, pin3=1, pin2=0
	beq pin4off

	cmp r4, #4	@pin5=1, pin4=0, pin3=1, pin2=1
	beq pin4off

	cmp r4, #1	@pin5=1, pin4=1, pin3=1, pin2=0
	beq pin4on

	cmp r4, #0	@pin5=1, pin4=1, pin3=1, pin2=1
	beq pin4on

pin3off:
	@ Write a logic 0 to turn pin3 off.
 
       ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite

	@cmp statements
	cmp r4, #15	@pin5=0, pin4=0, pin3=0, pin2=0
	beq pin4off

	cmp r4, #14	@pin5=0, pin4=0, pin3=0, pin2=1
	beq pin4off

	cmp r4, #11	@pin5=0, pin4=1, pin3=0, pin2=0
	beq pin4on

	cmp r4, #10	@pin5=0, pin4=1, pin3=0, pin2=1
	beq pin4on

	cmp r4, #7	@pin5=1, pin4=0, pin3=0, pin2=0
	beq pin4off

	cmp r4, #6	@pin5=1, pin4=0, pin3=0, pin2=1
	beq pin4off

	cmp r4, #3	@pin5=1, pin4=1, pin3=0, pin2=0
	beq pin4on

	cmp r4, #2	@pin5=1, pin4=1, pin3=0, pin2=1
	beq pin4on

pin4on:
	@ Write a logic one to turn pin4 to on.


        ldr     r0, =pin4

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite

	@cmp statements
	cmp r4, #11	@pin5=0, pin4=1, pin3=0, pin2=0
	beq pin5off

	cmp r4, #10	@pin5=0, pin4=1, pin3=0, pin2=1
	beq pin5off

	cmp r4, #9	@pin5=0, pin4=1, pin3=1, pin2=0
	beq pin5off

	cmp r4, #8	@pin5=0, pin4=1, pin3=1, pin2=1
	beq pin5off

	cmp r4, #3	@pin5=1, pin4=1, pin3=0, pin2=0
	beq pin5on

	cmp r4, #2	@pin5=1, pin4=1, pin3=0, pin2=1
	beq pin5on

	cmp r4, #1	@pin5=1, pin4=1, pin3=1, pin2=0
	beq pin5on

	cmp r4, #0	@pin5=1, pin4=1, pin3=1, pin2=1
	beq pin5on

pin4off:
	@ Write a logic 0 to turn pin4 off.
 
       ldr     r0, =pin4

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite

	@cmp statements
	cmp r4, #15	@pin5=0, pin4=0, pin3=0, pin2=0
	beq pin5off

	cmp r4, #14	@pin5=0, pin4=0, pin3=0, pin2=1
	beq pin5off

	cmp r4, #13	@pin5=0, pin4=0, pin3=1, pin2=0
	beq pin5off

	cmp r4, #12	@pin5=0, pin4=0, pin3=1, pin2=1
	beq pin5off

	cmp r4, #7	@pin5=1, pin4=0, pin3=0, pin2=0
	beq pin5on

	cmp r4, #6	@pin5=1, pin4=0, pin3=0, pin2=1
	beq pin5on

	cmp r4, #5	@pin5=1, pin4=0, pin3=1, pin2=0
	beq pin5on

	cmp r4, #4	@pin5=1, pin4=0, pin3=1, pin2=1
	beq pin5on

pin5on:
	@ Write a logic one to turn pin5 to on.


        ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #1

       	bl      digitalWrite
		
	b delayblock

pin5off:
	@ Write a logic 0 to turn pin5 off.
 
       ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite

	b delayblock
	
delayblock:
@ Run the delay otherwise it blinks so fast you never see it!

@ To use the delay function:

@    r0 - must contains the number of miliseconds to delay.
 

       ldr     r0, =delayMs

        ldr     r0, [r0]

        bl      delay
	
	sub r4, r4, #1	@decrement loop counter

	b	hexcount

hexrounddone:
	sub r8, r8, #1	@decrement how many times to print hex numbers

	cmp r8, #0
	blt afterhex

	b hexloop

afterhex:
@print another string
	ldr	r0, =task3string
	bl	printf

@ To use the digitalWrite function:

@    r0 - must contain the pin number for the GPIO per the header file info

@    r1 - set to 1 to turn the output on or to 0 to turn the output off.

@

@ Turn all four LEDs on. 

@

@ Write a logic one to turn pin2 to on.


        ldr     r0, =pin2

        ldr     r0, [r0]
        mov     r1, #1

        bl      digitalWrite


@ Write a logic one to turn pin3 to on.


        ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite


@ Write a logic one to turn pin4 to on.


        ldr     r0, =pin4

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite


@ Write a logic one to turn pin5 to on.


        ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #1

        bl      digitalWrite


@ Run the delay otherwise it blinks so fast you never see it!

@ To use the delay function:

@    r0 - must contains the number of miliseconds to delay.
 

       ldr     r0, =delayMs

        ldr     r0, [r0]

        bl      delay

@

@ Turn all four LEDs off

@

@ Write a logic 0 to turn pin2 off.
 
       ldr     r0, =pin2

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite


@ Write a logic 0 to turn pin3 off.
 
       ldr     r0, =pin3

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite
@ Write a logic 0 to turn pin4 off.
 
       ldr     r0, =pin4

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite


@ Write a logic 0 to turn pin5 off.
 
       ldr     r0, =pin5

        ldr     r0, [r0]

        mov     r1, #0

        bl      digitalWrite


@ Run the delay otherwise it blinks so fast you never see it!

        ldr     r0, =delayMs

        ldr     r0, [r0]

        bl      delay



@ Use the C library to print the goodbye string.
 
   LDR  r0, =string2 @ Put address of string in r0

    BL   printf       @ Make the call to printf



@ Force the exit of this program and return command to OS

errorout:  @ Label only need if there is an error on board init.
    

mov  r0, r8
    MOV  r7, #0X01

    SVC  0



@ Define all the data elements 

.data

.balign 4


@ Define the values for the pins


pin2: .word 2 

pin3: .word 3

pin4: .word 4

pin5: .word 5


i:    .word 0    @ counter for for loop. 



delayMs: .word 1000  @ Set delay for one second. 

.balign 4

string1: .asciz "Raspberry Pi Blinking Light with Assembly. \n"


.balign 4

string1a: .asciz "The LEDs will blink once.  \n" 


.balign 4

string2: .asciz "The four LEDs should have blinked. \n"


.balign 4
task3string: .asciz "The four LEDs will blink again. \n"

.balign 4
task2string: .asciz "The four LEDs will print the hex numbers 0-F. \n"

.balign 4

ErrMsg: .asciz "Setup didn't work... Aborting...\n"




.global printf


@

@  The following are defined in wiringPi.h

@
.extern wiringPiSetup 

.extern delay

.extern digitalWrite

.extern pinMode


@end of code and end of file. Leave a blank line after this


