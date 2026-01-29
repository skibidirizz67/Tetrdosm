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
    j exit

    .section .data
    .global playfield # TODO: cell buffer zone
                      # TODO: tetriton
                      # TODO? move to .bss and initialize on start
#bufferzone: .ascii "..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n"
#spawnzone: .ascii "..........\n..........\n"
playfield: .ascii "..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n"
floor: .ascii "..........\n"
