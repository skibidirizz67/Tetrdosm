    .section .text
    .global write
write:
    li a0, 1
    la a1, playfield
    li a2, 11*20
    li a7, 64
    ecall
    ret

    .global clear
clear:
    li a0, 1
    la a1, clear_msg
    li a2, 5
    li a7, 64
    ecall
    ret

    .global cwrite
cwrite:
    li a0, 1
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
clear_msg: .ascii "\x1B[20A"
triggermsg: .ascii " !!!"
