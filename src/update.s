    .macro R_EMP
    s3
    .endm
    .macro R_FAL
    s2
    .endm
    .macro R_STA
    s5
    .endm
    .macro R_PFD
    s0
    .endm
    .macro R_BAG
    s7
    .endm
    .macro R_BGM
    s9
    .endm
    .macro R_FLR
    s6
    .endm
    
    .section .text
.global init
init:
    la s0, playfield
    li s3, '.'
    li s2, '#'
    li s5, '@'
    la s7, b7bag
    li s9, 7
    la s6, floor
    li s8, -1
    j spawn

    .global update
update:
    addi s1, s0, 11*20-1
    0:
    beq s1, s0, 2f
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 0b
    lb t1, 11(s1)
    beq t1, s5, 1f
    blt s1, s6, 0b
    1:
    mv t0, ra
    jal lock
    jal spawn
    mv ra, t0
    ret
    2:
    addi s1, s0, 11*20-1
    rwhile:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 4f
    sb s2, 11(s1)
    sb s3, 0(s1)
    4:
    bne s1, s0, rwhile
    ret

lock:
    addi s1, s0, 11*20-1
    bwhile:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f
    sb s5, 0(s1)
    1:
    bne s1, s0, bwhile
    ret

fill:
    # TODO: make fill more efficient and smart
    li s8, 0
    li a1, 1
    li a7, 278
    2:
    add a0, s7, s8
    ecall
    add a0, s7, s8
    lb t1, 0(a0)
    remu t3, t1, s9
    li t2, -1
    4:
    addi t2, t2, 1
    add t4, s7, t2
    lb t4, 0(t4)
    beq t2, s8, 3f
    beq t3, t4, 2b
    j 4b
    3:
    sb t3, 0(a0)
    addi s8, s8, 1
    bne s8, s9, 2b
    addi s8, s8, -1
    ret

spawn:
    li t1, -1
    bne s8, t1, 1f
    mv t5, ra
    jal fill
    mv ra, t5
    1:
    add t1, s7, s8
    lb t1, 0(t1)
    li t2, 0 # 'L'
    bne t1, t2, 2f
    sb s2, 3(s0)
    sb s2, 4(s0)
    sb s2, 5(s0)
    sb s2, 6(s0)
    j 3f
    2:
    li t2, 1 # 'J'
    bne t1, t2, 2f
    sb s2, 3(s0)
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    j 3f
    2:
    li t2, 2 # 'L'
    bne t1, t2, 2f
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    sb s2, 5(s0)
    j 3f
    2:
    li t2, 3 # 'O'
    bne t1, t2, 2f
    sb s2, 4(s0)
    sb s2, 5(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    j 3f
    2:
    li t2, 4 # 'S'
    bne t1, t2, 2f
    sb s2, 3(s0)
    sb s2, 4(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    j 3f
    2:
    li t2, 5 # 'T'
    bne t1, t2, 2f
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 4(s0)
    sb s2, 16(s0)
    j 3f
    2:
    li t2, 6 # 'Z'
    bne t1, t2, 2f
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 4(s0)
    sb s2, 5(s0)
    j 3f
    2:
    sb s2, 0(s0)
    3:
    addi s8, s8, -1
    ret

    .section .data
b7bag: .skip 7
