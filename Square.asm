// Square.asm - Compute y = x^2
// Input: R0 contains x
// Output: R1 contains x^2
// Does not modify R0

@R0
D=M        // D = x
@R1
M=0        // R1 = 0 (sum = 0)
@R2
M=D        // R2 = x (counter)

(LOOP)
  @R2
  D=M
  @END
  D;JEQ    // If counter == 0, exit loop

  @R0
  D=M      // D = x
  @R1
  M=M+D    // R1 = R1 + x (sum += x)

  @R2
  M=M-1    // counter--

  @LOOP
  0;JMP    // Repeat loop

(END)
  @END
  0;JMP    // Infinite loop
