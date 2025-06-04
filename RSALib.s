.section .text
.global gcd, powmod, modinv, pow, mod, encrypt, decrypt
.global read_int, print_int, read_string, print_string
.global write_file, read_file

gcd:
    cmp r1, #0
    beq gcd_done
    

gcd_loop:
    bl modulo
    mov r3, r0
    mov r1, r0
    mov r1, r3
    cmp r1, #0
    bne gcd_loop
    
gcd_done:
    bx lr

modulo:
    cmp r0, r1         @ while a >= b
    blt mod_done

mod_loop:
    sub r0, r0, r1     @ a = a - b
    cmp r0, r1
    bge mod_loop

mod_done:
    bx lr              @ return a in r0

pow:
    mov r2, #1
    cmp r1, #0
    beq pow_end

pow_loop:
    mul r2, r0, r2
    subs r1, r1, #1
    bne power_loop

pow_end:
   bx lr		@ return result in r2


print:
    mov r1, r2        @ Store character in r1
    ldr r0, =out      @ Output buffer
    strb r1, [r0]     @ Store byte to string

    mov r0, #1        @ stdout
    ldr r1, =out      @ pointer to buffer
    mov r2, #2        @ length (digit + \n)
    mov r7, #4        @ syscall write
    svc 0

    bx lr             @ Return
