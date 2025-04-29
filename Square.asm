// Square.asm
// Program: Compute y = x * x
// Inputs: x is stored in R0
// Output: y is stored in R1
// Important: Must not modify R0

// Initialize
@R0
D=M          // D = x
@R2
M=D          // Copy x into R2 (counter)
@R1
M=0          // Initialize R1 = 0 (accumulator)

// If x == 0, jump to END
@R2
D=M
@END
D;JEQ

(LOOP)
// Each iteration adds x to R1
@R0
D=M          // D = x
@R1
M=D+M        // R1 = R1 + x

// Decrease counter R2 by 1
@R2
M=M-1

// Check if counter reaches zero
@R2
D=M
@END
D;JEQ

// Otherwise, repeat loop
@LOOP
0;JMP

(END)
// Infinite loop to stop program
@END
0;JMP