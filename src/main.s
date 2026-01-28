    .section .text
    .global _start
_start:
    # set gp
    .option push
    .option norelax
    lla gp, __global_pointer$
    .option pop
    jal spawn
    1:
    jal write
    jal update
    jal sleep
    jal clear
    j 1b
    j exit

    .section .data
    .global playfield # TODO: cell buffer zone
                      # TODO? move to .bss and initialize on start
playfield: .ascii "..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n"
