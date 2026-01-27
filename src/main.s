    .section .text
    .global _start
_start:
    # set gp
    .option push
    .option norelax
    lla gp, __global_pointer$
    .option pop
    jal write
    jal update
    jal sleep
    j _start
    j exit

update:
    la s0, playfield
    li s1, 11*20-3
    li s2, '#'
    li s3, '.'
    while:
    add s4, s0, s1
    lb s5, 0(s4)
    bne s5, s2, skip
    sb s2, 11(s4)
    sb s3, 0(s4)
    skip:
    addi s1, s1, -1
    bnez s1, while 
    ret

    .section .data
    .global playfield
playfield: .ascii ".....#....\n....###...\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n\n"
