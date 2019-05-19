/**
 * Rotates an entity by a given rotation ptr to a certain target angle.
 * This function takes a angle difference in both directions and a step size as
 * parameters, to determine the direction it should rotate into.
 *
 * If the target angle is reached the function will return 1, otherwise 0.
 * Bug: If the rotational difference in both directions is the same, this
 *      function will never return 1 and softlock the game.
 */
int rotateEntity(rotationPtr, targetAngle, cClockwiseDiff, clockwiseDiff, rotationSpeed) {
  currentRotation = load(r4 + 0x02) // rotation
  
  if(currentRotation < targetAngle) {
    // Bug: No cClockwiseDiff == clockwiseDiff case
    if(cClockwiseDiff < clockwiseDiff) {
      newRotation = currentRotation - rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(newRotation >= targetAngle - 0x1000)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
    else if(clockwiseDiff < cClockwiseDiff) {
      newRotation = currentRotation + rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(targetAngle >= newRotation)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
  }
  else if(targetAngle < currentRotation) {
    // Bug: No cClockwiseDiff == clockwiseDiff case
    if(cClockwiseDiff < clockwiseDiff) {
      newRotation = currentRotation - rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(newRotation >= targetAngle)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
    else if(clockwiseDiff < cClockwiseDiff) {
      newRotation = currentRotation + rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(targetAngle + 0x1000 >= newRotation)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
  }
  else {
    store(rotationPtr + 0x02, targetAngle)
    return 1
  }
  
  return 0
}

0x000b6fb0 lh r8,0x0000(r6)
0x000b6fb4 lh r2,0x0000(r5)
0x000b6fb8 lh r6,0x0002(r4)
0x000b6fbc lh r3,0x0010(r29)
0x000b6fc0 addu r5,r6,r0
0x000b6fc4 lh r7,0x0000(r7)
0x000b6fc8 slt r1,r5,r2
0x000b6fcc beq r1,r0,0x000b703c
0x000b6fd0 addu r9,r5,r0
0x000b6fd4 slt r1,r8,r7
0x000b6fd8 beq r1,r0,0x000b7008
0x000b6fdc nop
0x000b6fe0 sub r3,r6,r3
0x000b6fe4 sh r3,0x0002(r4)
0x000b6fe8 lh r3,0x0002(r4)
0x000b6fec addi r5,r2,-0x1000
0x000b6ff0 slt r1,r3,r5
0x000b6ff4 beq r1,r0,0x000b70bc
0x000b6ff8 nop
0x000b6ffc sh r2,0x0002(r4)
0x000b7000 beq r0,r0,0x000b70c0
0x000b7004 addiu r2,r0,0x0001
0x000b7008 slt r1,r7,r8
0x000b700c beq r1,r0,0x000b70bc
0x000b7010 nop
0x000b7014 add r3,r6,r3
0x000b7018 sh r3,0x0002(r4)
0x000b701c lh r3,0x0002(r4)
0x000b7020 nop
0x000b7024 slt r1,r2,r3
0x000b7028 beq r1,r0,0x000b70bc
0x000b702c nop
0x000b7030 sh r2,0x0002(r4)
0x000b7034 beq r0,r0,0x000b70c0
0x000b7038 addiu r2,r0,0x0001
0x000b703c slt r1,r2,r9
0x000b7040 beq r1,r0,0x000b70b0
0x000b7044 nop
0x000b7048 slt r1,r8,r7
0x000b704c beq r1,r0,0x000b707c
0x000b7050 nop
0x000b7054 sub r3,r6,r3
0x000b7058 sh r3,0x0002(r4)
0x000b705c lh r3,0x0002(r4)
0x000b7060 nop
0x000b7064 slt r1,r3,r2
0x000b7068 beq r1,r0,0x000b70bc
0x000b706c nop
0x000b7070 sh r2,0x0002(r4)
0x000b7074 beq r0,r0,0x000b70c0
0x000b7078 addiu r2,r0,0x0001
0x000b707c slt r1,r7,r8
0x000b7080 beq r1,r0,0x000b70bc
0x000b7084 nop
0x000b7088 add r3,r6,r3
0x000b708c sh r3,0x0002(r4)
0x000b7090 lh r3,0x0002(r4)
0x000b7094 addi r5,r2,0x1000
0x000b7098 slt r1,r5,r3
0x000b709c beq r1,r0,0x000b70bc
0x000b70a0 nop
0x000b70a4 sh r2,0x0002(r4)
0x000b70a8 beq r0,r0,0x000b70c0
0x000b70ac addiu r2,r0,0x0001
0x000b70b0 sh r2,0x0002(r4)
0x000b70b4 beq r0,r0,0x000b70c0
0x000b70b8 addiu r2,r0,0x0001
0x000b70bc addu r2,r0,r0
0x000b70c0 jr r31
0x000b70c4 nop