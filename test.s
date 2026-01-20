    .section .text
    .global _start
_start:
    li a0, 42        # exit code
    li a7, 93        # exit syscall
    ecall
