    .section .text
    .global _start
_start:
    # set gp
    .option push
    .option norelax
    lla gp, __global_pointer$
    .option pop
    jal init
    1:
    jal write
    jal update
    jal sleep
    jal clear
    j 1b

    .section .data
    .global playfield
playfield: .ascii "..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n"
floor: .ascii "..........\n"
