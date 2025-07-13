.section .text
.global main

main:

    sub sp, sp, #4
    str lr, [sp]
    
    LDR r0, =p_prompt
    BL printf           @ prompt for p

    LDR r0, =int_format @ Store p
    LDR r1, =num
    BL scanf            @ Read p

    LDR r1, =num
    LDR r4, [r1, #0]

    LDR r0, =q_prompt
    BL printf
    LDR r0, =int_format
    LDR r1, =num
    BL scanf
    LDR r1, =num
    LDR r5, [r1, #0]

    
    MOV r0, r4
    MOV r1, r5
    BL phi

    MOV r1, r0
    MOV r4, r0
    LDR r0, =phiResult
    BL printf

    # Ask for e until input is valid

    MOV r0, r4
    bl get_e
    

    ldr lr, [sp]
    add sp, sp, #4
    mov pc, lr

#END main

get_e:
SUB sp, sp, #4
STR lr, [sp, #0]

# copy phi to r5 for reuse
MOV r5, r0
BL get_e_loop

get_e_loop:
    MOV r1, r5
    LDR r0, =e_prompt
    BL printf

    LDR r0, =int_format
    LDR r1, =num
    BL scanf

    LDR r1, =num
    LDR r0, [r1, #0]

    # put phi in r1 and e in r0 and copy e to r6
    MOV r6, r0
    MOV r1, r5
    bl gcd

    cmp r0, #1
    bne get_e_loop

    MOV r0, r6

# Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
    
#END get_e




.data
	p_prompt:   .asciz "Enter a value for p:"
	q_prompt:   .asciz "Enter a value for q:"
	e_prompt:   .asciz "Enter a value for e that is between 1 and %d: \n"
    phiResult:  .asciz "phi: %d \n"
	int_format: .asciz "%d"
    p:          .word 0
    q:          .word 0
    e:          .word 0
    num:        .word 0
    msg:        .space 128
