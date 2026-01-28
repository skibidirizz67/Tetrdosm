    .section .text
    .global update
update:
    la s0, playfield
    li s1, 11*20-1 # TODO: replace counter s4 with s1 + s0
    li s6, 11*19+1
    li s2, '#'
    li s3, '.'
    li s5, '@'
    while:
    addi s1, s1, -1
    add s4, s0, s1
    lb t1, 0(s4)
    bne t1, s2, 1f
    lb t2, 11(s4)
    beq t2, s5, 2f
    blt s1, s6, 1f
    2:
    mv t0, ra
    jal bake
    jal spawn
    mv ra, t0
    ret
    1:
    bnez s1, while
    li s1, 11*20-1
    rwhile:
    addi s1, s1, -1
    add s4, s0, s1
    lb t1, 0(s4)
    bne t1, s2, 1f
    sb s2, 11(s4)
    sb s3, 0(s4)
    1:
    bnez s1, rwhile
    ret

bake:
    li s1, 11*20-1
    bwhile:
    addi s1, s1, -1
    add s4, s0, s1
    lb t1, 0(s4)
    bne t1, s2, 1f
    sb s5, 0(s4)
    1:
    bnez s1, bwhile
    ret

    .global spawn
spawn:
    sb s2, 4(s4)
    sb s2, 14(s4)
    sb s2, 15(s4)
    sb s2, 16(s4)
    ret
