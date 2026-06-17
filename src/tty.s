    .section .text
    .global settty
    .global resettty
settty:
# get current tty settings
    li a0, 0
    li a1, 0x5401 # TCGETS
    la a2, tty_old
    li a7, 29 # ioctl
    ecall
# copy to a new variable
    la a0, tty_new
    la a1, tty_old
    li a2, 26
memcpy:
    lbu a3, 0(a1)
    sb a3, 0(a0) 
    addi a0, a0, 1
    addi a1, a1, 1 
    addi a2, a2, -1
    bnez a2, memcpy
    li a0, 0
# modify c_lflag
    la a0, tty_new
    lw a1, 12(a0)
    li a2, 0xFFFFFFF5 # (unsigned) ~(ICANON|ECHO)
    and a1, a1, a2
    sw a1, 12(a0)
# modfiy c_cc[VTIME]
    li a1, 0x01
    sh a1, 22(a0) # we are using half word to also set VMIN (most significant byte) to 0
# set new tty settings
    li a0, 0
    li a1, 0x5402 # TCSETS
    la a2, tty_new
    li a7, 29 # ioctl
    ecall
    ret
# receive and print characters until newline
    li a0, 0
    la a1, char
    li a3, 0x0A # \n
    while:
    li a2, 1
    li a7, 63
    ecall
    li a2, 2
    li a7, 64
    ecall
    lb a4, char
    bne a3, a4, while
resettty:
# set old tty settings back
    li a0, 0
    li a1, 0x5402 # TCSETS
    la a2, tty_old
    li a7, 29 # ioctl
    ecall
    li a0, 0
    li a7, 93
    ecall

    .section .data
    .global char
char: .ascii " \n"
# struct __kernel_termios {
#     unsigned int c_iflag;
#     unsigned int c_oflag;
#     unsigned int c_cflag;
#     unsigned int c_lflag;
#     unsigned char c_line;
#     unsigned char c_cc[__KERNEL_NCCS]; # __KERNEL_NCCS == 19
# }
tty_old:
.align 3
.word 0, 0, 0, 0 
.byte 0
.fill 19, 1, 0
tty_new:
.align 3
.word 0, 0, 0, 0
.byte 0
.fill 19, 1, 0
