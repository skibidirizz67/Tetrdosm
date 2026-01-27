    .section .text
    .global write
write:
    li a0, 1
    la a1, playfield
    li a2, 11*20+1
    li a7, 64
    ecall
    ret

.global trigger
trigger:
    li a0, 1
    la a1, triggermsg
    li a2, 4
    li a7, 64
    ecall
    ret

    .section .data
triggermsg: .ascii "!!! "
