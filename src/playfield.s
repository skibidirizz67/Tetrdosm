    .section .text
    .global update
update:
    addi s1, s0, 11*20-1 # counter (playfield end)
check_obstacles:
    beq s1, s0, mdown # move down if no obstacles
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, check_obstacles # skip if not falling block
    lb t1, 11(s1)               # lock if static block
    beq t1, s5, lock            # directly under
    blt s1, s6, check_obstacles # or if on floor
lock:
    addi s1, s0, 11*20-1 # counter (playfield end)
    0:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f # skip if not falling block
    sb s5, 0(s1) # lock
    1:
    bne s1, s0, 0b
check_lines:
    j spawn # after locking, spawn new tetromino
mdown:
    addi s1, s0, 11*20-1 # counter (playfield end)
    0:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f # skip if not falling block
    sb s3, 0(s1) # move down
    sb s2, 11(s1)
    1:
    bne s1, s0, 0b
    ret

mleft:
    addi t2, s0, 11*20-1 # counter (playfield end)
    addi s1, s0, -1
    li t3, 11
    0:
    addi s1, s1, 1
    lb t1, 0(s1)
    bne t1, s2, 1f # skip if not falling block
    sb s3, 0(s1) # move left
    sb s2, -1(s1)
    1:
    bne s1, t2, 0b
    ret

mright:
    addi s1, s0, 11*20-1 # counter (playfield end)
    0:
    addi s1, s1, -1
    lb t1, 0(s1)
    bne t1, s2, 1f # skip if not falling block
    sb s3, 0(s1) # move right
    sb s2, 1(s1)
    1:
    bne s1, s0, 0b
    ret

    .global spawn
spawn: # TODO: replace this ugly shit with data-driven block offsets
    bgt s8, zero, 0f
    # fill the bag if it is empty
    mv t0, ra
    jal fill
    mv ra, t0
    0:
    add t1, s7, s8
    addi s8, s8, -1
    lb t1, 0(t1) # get tetromino from the bag
    li t2, 0 # 'I'
    beq t1, t2, spawn_I
    li t2, 1 # 'J'
    beq t1, t2, spawn_J
    li t2, 2 # 'L'
    beq t1, t2, spawn_L
    li t2, 3 # 'O'
    beq t1, t2, spawn_O
    li t2, 4 # 'S'
    beq t1, t2, spawn_S
    li t2, 5 # 'T'
    beq t1, t2, spawn_T
    li t2, 6 # 'Z'
    beq t1, t2, spawn_Z
    j spawn_ERR
spawn_I:
    # check top-out
    lb t1, 3(s0)
    beq t1, s5, exit
    lb t1, 4(s0)
    beq t1, s5, exit
    lb t1, 5(s0)
    beq t1, s5, exit
    lb t1, 6(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 3(s0)
    sb s2, 4(s0)
    sb s2, 5(s0)
    sb s2, 6(s0)
    ret
spawn_J:
    # check top-out
    lb t1, 3(s0)
    beq t1, s5, exit
    lb t1, 14(s0)
    beq t1, s5, exit
    lb t1, 15(s0)
    beq t1, s5, exit
    lb t1, 16(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 3(s0)
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    ret
spawn_L:
    # check top-out
    lb t1, 14(s0)
    beq t1, s5, exit
    lb t1, 15(s0)
    beq t1, s5, exit
    lb t1, 16(s0)
    beq t1, s5, exit
    lb t1, 5(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    sb s2, 5(s0)
    ret
spawn_O:
    # check top-out
    lb t1, 4(s0)
    beq t1, s5, exit
    lb t1, 5(s0)
    beq t1, s5, exit
    lb t1, 15(s0)
    beq t1, s5, exit
    lb t1, 16(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 4(s0)
    sb s2, 5(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    ret
spawn_S:
    # check top-out
    lb t1, 3(s0)
    beq t1, s5, exit
    lb t1, 4(s0)
    beq t1, s5, exit
    lb t1, 15(s0)
    beq t1, s5, exit
    lb t1, 16(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 3(s0)
    sb s2, 4(s0)
    sb s2, 15(s0)
    sb s2, 16(s0)
    ret
spawn_T:
    # check top-out
    lb t1, 14(s0)
    beq t1, s5, exit
    lb t1, 15(s0)
    beq t1, s5, exit
    lb t1, 4(s0)
    beq t1, s5, exit
    lb t1, 16(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 4(s0)
    sb s2, 16(s0)
    ret
spawn_Z:
    # check top-out
    lb t1, 14(s0)
    beq t1, s5, exit
    lb t1, 15(s0)
    beq t1, s5, exit
    lb t1, 4(s0)
    beq t1, s5, exit
    lb t1, 5(s0)
    beq t1, s5, exit
    # spawn
    sb s2, 14(s0)
    sb s2, 15(s0)
    sb s2, 4(s0)
    sb s2, 5(s0)
    ret
spawn_ERR:
    sb s2, 0(s0)
    ret

    .section .data
    .global playfield
playfield: .ascii "..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n"
    .global floor
floor: .ascii "..........\n"
