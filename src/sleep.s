    .section .text
    .global sleep
sleep:
    la a0, 0
    la a1, char
    li a2, 1
    li a7, 63
    ecall
    ret

    .section .data
.balign 8
timespec:
    .8byte 0
    .8byte 1000000*500 # 1e6 == 1 ms
