    .section .text
    .global sleep
sleep:
    la a0, timespec
    li a1, 0
    li a7, 101
    ecall
    ret

    .section .data
.balign 8
timespec:
    .8byte 0
    .8byte 1000000*100 # 1e6 == 1 ms
