    .section .text
    .global exit
exit:
    jal print_game_over
    jal resettty
    li a0, 0
    li a7, 93
    ecall
