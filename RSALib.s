.section .text
.global gcd, pow, is_prime, phi, modulo, modinv, encrypt, decrypt


is_prime:
    # allocate space on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Number is prime if modulo is greater than 0
    BL modulo
    CMP r0, #0
    MOVEQ r0, #1
    MOVNE r0, #0
    
    
    # Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

#END is_prime

# Returns totient (p-1)(q-1)
phi:
    # allocate space on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    SUB r0, r0, #1
    SUB r1, r1, #1
    MUL r0, r0, r1

    # Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END phi


gcd:
    # allocate space on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    cmp r1, #0
    beq gcd_done

# swap e and phi for modulus
    MOV r2, r0
    MOV r0, r1
    MOV r1, r2

gcd_loop:
    # store r1 in r3 for later
    MOV r3, r1
    BL modulo

    # b = a%b
    MOV r1, r0

    # a = original b
    MOV r0, r3

# continue while b != 0
    CMP r1, #0
    BGT gcd_loop

    
gcd_done:
    # Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

modulo:
    # allocate space on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    CMP r0, r1         @ while a >= b
    BLT mod_done

mod_loop:
    SUB r0, r0, r1     @ a = a - b
    CMP r0, r1
    BGE mod_loop

mod_done:
    # Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr         @ return a in r0

pow:
    # allocate space on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r2, #1
    CMP r1, #0
    BEQ pow_end

pow_loop:
    MUL r2, r0, r2
    SUBS r1, r1, #1
    BNE pow_loop

pow_end:
    # Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr		@ return result in r2

#END pow

cprivexp:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    

#END cprivexp

# Modulo inverse using Extended Euclidean Algorithm
modinv:
    # Allocate space on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    mov r4, #0               @ t = 0
    mov r5, #1               @ newt = 1
    mov r6, r1               @ r = phi
    mov r7, r0               @ newr = e

modinv_loop:
    cmp r7, #0
    beq modinv_exit

    @ quotient = r / newr
    mov r0, r6               @ dividend (r)
    mov r1, r7               @ divisor (newr)
    bl __aeabi_idiv
    mov r3, r0               @ store quotient in r3

    @ t, newt update
    mov r0, r4               @ temp = t
    mov r4, r5               @ t = newt
    mul r1, r3, r5           @ r1 = quotient * newt
    sub r5, r0, r1           @ newt = temp - quotient * newt

    @ r, newr update
    mov r0, r6               @ temp = r
    mov r6, r7               @ r = newr
    mul r1, r3, r7           @ r1 = quotient * newr
    sub r7, r0, r1           @ newr = temp - quotient * newr

    b modinv_loop

modinv_exit:
    cmp r4, #0
    bge modinv_return        @ If t >= 0, done

    add r4, r4, r1           @ t += phi

modinv_return:
    mov r0, r4               @ Return d
    # Return process
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr



decrypt:
#TODO

encrypt:
#TODO
