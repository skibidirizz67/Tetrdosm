    .section .text
    .extern "ncurses.h"
    .extern "initscr"
    .global _start
_start:
    # set gp
    .option push
    .option norelax
    lla gp, __global_pointer$
    .option pop
enable_raw:
    call initscr
    j exit



#init: # TODO: refactor registers
#    la s0, playfield
#    li s3, '.'
#    li s2, '#'
#    li s5, '@'
#    la s7, bag
#    li s9, 7
#    la s6, floor
#    li s8, -1
#    jal spawn
#while:
#    jal write
#    jal update
#    jal sleep
#    jal clear
#    j while
