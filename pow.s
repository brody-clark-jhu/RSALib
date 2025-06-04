.global _start

_start:
    mov r0, #3	@ base
    mov r1, #4	@ power
    bl power
    
    mov r7, #1         @ syscall exit
    mov r0, #0
    svc 0

    

power:
    mov r2, #1
    cmp r1, #0
    beq end

power_loop:
    mul r2, r0, r2
    subs r1, r1, #1
    bne power_loop

end:
   bx lr

.section .data
buf: 
    .asciz " \n"
