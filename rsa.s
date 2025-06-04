
.global _start


_start:
    mov r0, #48 @ number 1
    mov r1, #18 @ number 2
    bl gcd
    mov r7, #1            @ syscall number for exit
    mov r0, #0            @ exit code
    svc 0                 @ make syscall

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
