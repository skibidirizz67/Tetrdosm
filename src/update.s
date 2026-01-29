    .section .text
    .global update
update: # TODO: explanation comments
        # TODO: refactor registers
    la s0, playfield
    addi s1, s0, 11*20-1
    addi s6, s0, 11*19+1
    li s2, '#'
    li s3, '.'
    li s5, '@'
    while:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f
    lb t2, 11(s1)
    beq t2, s5, 2f
    blt s1, s6, 1f
    2:
    mv t0, ra
    jal bake
    jal spawn
    mv ra, t0
    ret
    1:
    bne s1, s0, while
    addi s1, s0, 11*20-1
    rwhile:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f
    sb s2, 11(s1)
    sb s3, 0(s1)
    1:
    bne s1, s0, rwhile
    ret

bake:
    addi s1, s0, 11*20-1
    bwhile:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f
    sb s5, 0(s1)
    1:
    bne s1, s0, bwhile
    ret

    .global init
init:
    la s7, b7bag
    li s8, 0
    la s4, playfield
    la s2, '#'
spawn:
    bnez s8, 1f
    # fill
    li s9, 7
    li a1, 1
    li a7, 278
    2:
    add a0, s7, s8
    ecall
    add a0, s7, s8
    lb t1, 0(a0)
    remu t1, t1, s9
    sb t1, 0(a0)
    addi s8, s8, 1
    bne s8, s9, 2b
    addi s8, s8, -1
    1:
    add t1, s7, s8
    lb t1, 0(t1)
    li t2, 0 # 'L'
    bne t1, t2, 2f
    sb s2, 3(s4)
    sb s2, 4(s4)
    sb s2, 5(s4)
    sb s2, 6(s4)
    j 3f
    2:
    li t2, 1 # 'J'
    bne t1, t2, 2f
    sb s2, 3(s4)
    sb s2, 14(s4)
    sb s2, 15(s4)
    sb s2, 16(s4)
    j 3f
    2:
    li t2, 2 # 'L'
    bne t1, t2, 2f
    sb s2, 14(s4)
    sb s2, 15(s4)
    sb s2, 16(s4)
    sb s2, 5(s4)
    j 3f
    2:
    li t2, 3 # 'O'
    bne t1, t2, 2f
    sb s2, 4(s4)
    sb s2, 5(s4)
    sb s2, 15(s4)
    sb s2, 16(s4)
    j 3f
    2:
    li t2, 4 # 'S'
    bne t1, t2, 2f
    sb s2, 3(s4)
    sb s2, 4(s4)
    sb s2, 15(s4)
    sb s2, 16(s4)
    j 3f
    2:
    li t2, 5 # 'T'
    bne t1, t2, 2f
    sb s2, 14(s4)
    sb s2, 15(s4)
    sb s2, 4(s4)
    sb s2, 16(s4)
    j 3f
    2:
    li t2, 6 # 'Z'
    bne t1, t2, 2f
    sb s2, 14(s4)
    sb s2, 15(s4)
    sb s2, 4(s4)
    sb s2, 5(s4)
    j 3f
    2:
    sb s2, 0(s4)
    3:
    addi s8, s8, -1
    ret

    .section .data
b7bag: .skip 7
