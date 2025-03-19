// IntegerDivision.asm - Compute m = x / y and q = x % y
// Input: R0 = x, R1 = y
// Output: R2 = m (quotient), R3 = q (remainder), R4 = flag (1 if y=0, else 0)

// Check if y == 0
@R1
D=M
@ERROR
D;JEQ    // If y == 0, jump to ERROR

// Initialize
@R2
M=0      // R2 = m = 0
@R3
M=0      // R3 = q = 0

// Set q = x
@R0
D=M
@R3
M=D      // q = x

(LOOP)
  @R3
  D=M
  @R1
  D=D-M
  @END
  D;JLT   // If q < y, end loop

  @R3
  M=M-D   // q = q - y
  @R2
  M=M+1   // m++

  @LOOP
  0;JMP   // Repeat loop

(END)
  @R4
  M=0     // Set flag to 0
  @STOP
  0;JMP   // Jump to stop

(ERROR)
  @R4
  M=1     // Set error flag to 1
  @STOP
  0;JMP   // Jump to stop

(STOP)
  @STOP
  0;JMP   // Infinite loop
