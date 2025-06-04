.section .text
.global _start

_start:
    bl read_int         @ Read p
    mov r4, r0          @ Store p
    bl read_int         @ Read q
    mov r5, r0          @ Store q

    mul r6, r4, r5      @ n = p * q
    sub r0, r4, #1
    sub r1, r5, #1
    mul r7, r0, r1      @ phi = (p-1)(q-1)

    mov r0, #7          @ Try e = 7
    mov r1, r7          @ phi
    bl gcd
    cmp r0, #1
    bne _start          @ Retry with different e if not coprime

    mov r0, #7          @ r0 = e
    mov r1, r7          @ r1 = phi
    bl modinv           @ r0 = d

    mov r8, r0          @ d
    mov r0, #42         @ Example message
    mov r1, #7          @ e
    mov r2, r6          @ n
    bl encrypt
    mov r9, r0          @ Encrypted message

    mov r0, r9          @ ciphertext
    mov r1, r8          @ d
    mov r2, r6          @ n
    bl decrypt          @ Decrypted message in r0

    bl print_int        @ Print result

    mov r7, #1          @ exit
    mov r0, #0
    svc 0
