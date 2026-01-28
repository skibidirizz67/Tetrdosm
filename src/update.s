    .section .text
    .global update
update:
    la s0, playfield
    li s1, 11*20-1
    li s6, 11*19+1
    li s2, '#'
    li s3, '.'
    li s5, '@'
    while:
    addi s1, s1, -1
    add s4, s0, s1
    lb t1, 0(s4)
    bne t1, s2, 1f
    blt s1, s6, 2f
    mv t0, ra
    jal bake
    mv ra, t0
    ret
    2:
    sb s2, 11(s4)
    sb s3, 0(s4)
    1:
    bnez s1, while 
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
