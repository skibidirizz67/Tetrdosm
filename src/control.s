    .section .text
    .global handle_input
handle_input:
    beqz a0, return
    lb a0, char
    lb a1, key_down
    bne a0, a1, 1f
    j return
1:
    lb a1, key_left
    bne a0, a1, 1f
    j return
1:
    lb a1, key_right
    bne a0, a1, 1f
    j return
1:
    lb a1, key_rot_ccw
    bne a0, a1, 1f
    j return
1:
    lb a1, key_rot_cw
    bne a0, a1, 1f
    j return
1:
return:
    ret

    .section .data
key_down: .ascii " "
key_left: .ascii "a"
key_right: .ascii "d"
key_rot_ccw: .ascii "w"
key_rot_cw: .ascii "s"
