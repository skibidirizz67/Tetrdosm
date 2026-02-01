    .section .text
    .global exit
exit:
    jal print_game_over
    li a0, 0
    li a7, 93
    ecall
