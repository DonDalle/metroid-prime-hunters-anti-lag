@starting main program, setting up custom stack preserving registers. 
.long 0xE2000000
.long ReferenceLabel-8
ldr r0, CustomStack
stmdb r0!, {r1-r11, lr}




/*********************
MAIN PROGRAM
*********************/




/******************
VRAIABLES FOR MAIN PROGRAM
*******************/



@Returning from Main Program
ReturnFromProgram:
ldr r0, CustomStack
sub r0, r0, #0x30
ldmia r0!, {r1-r11, lr}
mov r0, #0x5
ldr r12, Return
bx r12

Return:
.long 0x37FBB2C




/***************
CUSTOM FUNCTIONS
**************/



/***************
VARIABLES FOR CUSTOM FUNCTIONS
**************/





@Cleaning rest up and terminating program
CustomStack:
.long CustomStack+0x200002C

EndofProgram:

.org (EndofProgram+4)&0xFFFFFFF8

ReferenceLabel:
.long 0x037FBACC
mov pc, #0x2000000
.org CustomStack+0x34
