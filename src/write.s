    .section .text
    .global write
write:
    li a0, 1
    la a1, playfield
    li a2, 11*20
    li a7, 64
    ecall
    ret

    .global print_game_over
print_game_over:
    li a0, 1
    la a1, game_over_msg
    li a2, 21
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

    .section .data
clear_msg: .ascii "\x1B[20A"
game_over_msg: .ascii "\nTop-out. Game over!\n"
