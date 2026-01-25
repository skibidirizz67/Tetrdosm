    .section .text
    .global sleep
sleep:
    la a0, timespec
    li a1, 0
    li a7, 101
    ecall
    ret

    .section .rodata
timespec:
    .dword 0
    .dword 1000000*100 # 1e6 == 1 ms
