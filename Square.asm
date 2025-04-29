// Square.asm
// Compute y = x², where x is stored in R0, and the result is stored in R1

@R0
D=M
@NEGATIVE
D;JLT        // If x < 0, jump to NEGATIVE branch

@R0
D=M
@R2
M=D          // Store x in R2 for counting (positive case)
@R1
M=0          // Initialize result R1 = 0

(LOOP)
@R2
D=M
@END
D;JEQ        // If counter R2 == 0, end the loop

@R0
D=M          // Load x again
@R1
M=D+M        // Add x to R1 (R1 += x)
@R2
M=M-1        // Decrement counter R2
@LOOP
0;JMP        // Repeat the loop

(NEGATIVE)
@R0
D=M
@R2
M=-D         // Take the absolute value of x: R2 = -x
@R1
M=0          // Initialize result R1 = 0

(LOOP_NEG)
@R2
D=M
@END
D;JEQ        // If counter R2 == 0, end the loop

@R2
D=M          // Load absolute x
@R1
M=D+M        // Add it to R1 (R1 += |x|)
@R2
M=M-1        // Decrement counter
@LOOP_NEG
0;JMP        // Repeat the loop

(END)
@END
0;JMP        // Infinite loop to halt the program
