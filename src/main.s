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
    jal clear
    j _start
    j exit

    .section .data
    .global playfield # TODO: cell buffer zone
playfield: .ascii ".....#....\n....###...\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n....#.....\n...###....\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n...@@.....\n"
